function[resultImage] = findImage(imageHost)
    nbLSB = 4;

    imageHost = im2uint8(imageHost);

    heightHost = size(imageHost,1);
    widthHost = size(imageHost,2);

    hideHeight = 0;
    hideWidth = 0;

    bitHide = 0;
    bitHeader = 1;

    listHeadersHeight = list();
    listHeadersWidth = list();

    listRedHideImage = list();
    listGreenHideImage = list();
    listBlueHideImage = list();

    listCoordHeadersStart = list();

    indexHeader = 0;
    indexRGB = 0;
    isCurrentHeader = %f;
    isCurrentHide = %f;

    percent = 0;
    tmp_percent = 0;
    eta = 0
    svg = 0

    continue_choice = %t;

    headerSize = 16;
    octSize = ceil(headerSize/(nbLSB-1)) * (nbLSB-1);

    lastHeaderX = 0;
    lastHeaderY = 0;

    // Waitbar
    bar = waitbar(0, "Step 1/3 - Finding Data...");

    timer();

    for y=1 : heightHost
        if (~(size(listHeadersHeight) == size(listHeadersWidth)) || size(listHeadersHeight) > floor((heightHost*widthHost)/64)) && continue_choice then
            n=messagebox("It seems your image might be corrupted!", "Warning", "warning", ["Stop" "Continue"], "modal");
            if n == 1 then
                //Close waitbar
                close(bar);
                resultImage = resume(imageHost);
            end
            continue_choice = %f;
        end
        tmp_percent = floor(y*100/heightHost);
        if ~(svg == tmp_percent) then
            time = timer();
            eta = floor((time/(tmp_percent-svg))*(100-tmp_percent))
        end

        svg = tmp_percent;

        waitbar(tmp_percent/100, "Step 1/3 - Finding Data..."+" - ETA: "+eta2string(eta), bar);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("Step 1/3 - Finding Data: %d percent\n", percent);
        end
       for x=1 : widthHost
           if bitget(imageHost(y,x,1), 1) == bitHide then
              isCurrentHeader = %f;
           end

           if isCurrentHeader && bitget(imageHost(y,x,1), 1) == bitHeader then
               for lsb=2 : nbLSB
                  listHeadersHeight(indexHeader)($+1) = bitget(imageHost(y,x,1), lsb);
                  listHeadersWidth(indexHeader)($+1) = bitget(imageHost(y,x,2), lsb);
               end
           end

           if ~isCurrentHeader && bitget(imageHost(y,x,1), 1) == bitHeader then
               indexHeader = indexHeader + 1;
               strHeaderHeight = ""
               strHeaderWidth = ""
               if indexHeader > 1 then
                  retStruct = check_header(lastHeaderX, lastHeaderY, listHeadersHeight, listHeadersWidth, indexHeader-1, listCoordHeadersStart);
                  listHeadersHeight = retStruct.listHeadersHeight;
                  listHeadersWidth = retStruct.listHeadersWidth;
                  indexHeader = retStruct.indexHeader;
                  listCoordHeadersStart = retStruct.listCoordHeadersStart;
               end
               for lsb=2 : nbLSB
                   if lsb==2 then
                       lastHeaderX = x;
                       lastHeaderY = y;
                      listHeadersHeight(indexHeader) = list(bitget(imageHost(y,x,1), lsb));
                      listHeadersWidth(indexHeader) = list(bitget(imageHost(y,x,2), lsb));
                   else
                      listHeadersHeight(indexHeader)($+1) = bitget(imageHost(y,x,1), lsb);
                      listHeadersWidth(indexHeader)($+1) = bitget(imageHost(y,x,2), lsb);
                   end
               end
               isCurrentHeader = %t;
           end
       end
    end

    retStruct = check_header(lastHeaderX, lastHeaderY, listHeadersHeight, listHeadersWidth, indexHeader, listCoordHeadersStart);
    listHeadersHeight = retStruct.listHeadersHeight;
    listHeadersWidth = retStruct.listHeadersWidth;
    indexHeader = retStruct.indexHeader;
    listCoordHeadersStart = retStruct.listCoordHeadersStart;

    waitbar(100, "Step 1/3 - Processing...", bar);

    // Get header size Can Use Function rewrite
    hideHeight = 0;
    one = 0;
    zero = 0;

    count = 0
    for it=1 : headerSize
        for h=1 : size(listHeadersHeight)
            if ~(octSize == size(listHeadersHeight(h))) then
                continue;
            end

            if it == 1 then
               count = count + 1;
            end
            if listHeadersHeight(h)(it) == 0 then
              zero = zero + 1;
            else
              one = one + 1;
            end
        end
        if one > zero then
            hideHeight = hideHeight + (2^(headerSize - it));
        end
        one = 0;
        zero = 0;
    end

    hideWidth = 0;
    one = 0;
    zero = 0;

    for it=1 : headerSize
        for h=1 : size(listHeadersWidth)
            if ~(octSize == size(listHeadersWidth(h))) then
                continue;
            end
            if listHeadersWidth(h)(it) == 0 then
              zero = zero + 1;
            else
              one = one + 1;
            end
        end
        if one > zero then
            hideWidth = hideWidth + (2^(headerSize - it));
        end
        one = 0;
        zero = 0;
    end

    if hideHeight > 0 && hideWidth > 0 && hideHeight <= heightHost && hideWidth <= widthHost then
       resultImage = imresize(imageHost, [hideHeight, hideWidth]);
    else
       messagebox("Error Corrupted Data", "Error", "error")
       //Close waitbar
       close(bar);

       //Error Return
       resultImage = resume(imageHost);
    end

    tmp_percent = 0;
    percent = 0;

    listStartImages = getListStartImages(listCoordHeadersStart(1));

    for i=1 : hideWidth*hideHeight*(nbLSB-1)
        listRedHideImage(i) = list();
        listGreenHideImage(i) = list();
        listBlueHideImage(i) = list();
    end

    for itImage=1 : size(listStartImages)

        indexBit = 0;

        heigthHideStart = listStartImages(itImage)(1);
        widthHideStart = listStartImages(itImage)(2);

        oneDimCoordStart = widthHideStart + (widthHost * (heigthHideStart - 1));
        oneDimCoordEnd = oneDimCoordStart + (hideWidth * hideHeight) - 1;

        tmp_percent = 0;
        percent = 0;
        svg = 0;
        eta = 0

        timer();

        for coord = oneDimCoordStart : oneDimCoordEnd
            tmp_percent = floor((coord-oneDimCoordStart)*100/(oneDimCoordEnd-oneDimCoordStart));
            if ~(svg == tmp_percent) then
                time = timer();
                eta = floor((time/(tmp_percent-svg))*(100-tmp_percent))
            end

            svg = tmp_percent;

            waitbar(tmp_percent/100, "Step 2/3 - Finding Image "+string(itImage)+"/"+string(size(listStartImages))+" - ETA: "+eta2string(eta), bar);

            y = ceil(coord/widthHost);
            x = coord - ((y - 1) * widthHost);

            for lsb=2 : nbLSB
                indexBit = indexBit + 1;

                if y > heightHost || x > widthHost then
                    listRedHideImage(indexBit)(itImage) = 1;
                    listGreenHideImage(indexBit)(itImage) = 1;
                    listBlueHideImage(indexBit)(itImage) = 1;
                else
                    y = ceil(coord/widthHost);
                    x = coord - ((y - 1) * widthHost);

                    listRedHideImage(indexBit)(itImage) = bitget(imageHost(y,x,1), lsb);
                    listGreenHideImage(indexBit)(itImage) = bitget(imageHost(y,x,2), lsb);
                    listBlueHideImage(indexBit)(itImage) = bitget(imageHost(y,x,3), lsb);
                end
            end
        end
    end

    // Comp Image Layer & Add to result image
    percent = 0;
    tmp_percent = 0;
    eta = 0;
    svg = 0;

    pix2get = hideHeight * hideWidth;
    one = 0;
    zero = 0;
    hidePix = 0;

    waitbar(0, "Step 3/3 - Rebuilding Image...", bar);

    timer();

    for oneDimCoord=1 : hideWidth*hideHeight
        //timer

        tmp_percent = floor(oneDimCoord*100/(hideWidth*hideHeight));
        if ~(svg == tmp_percent) then
            time = timer();
            eta = floor((time/(tmp_percent-svg))*(100-tmp_percent))
        end

        svg = tmp_percent;

        waitbar(tmp_percent/100, "Step 3/3 - Rebuilding Image..."+" - ETA: "+eta2string(eta), bar);
        if ~(tmp_percent == percent) then
            sca(handles.prevHideImage);
            imshow(resultImage);
            percent = tmp_percent;
            if modulo(tmp_percent, 10) == 0 then
                printf("Step 3/3 - Rebuilding Image: %d percent\n", percent);
            end
        end

       resPix = findPix(((oneDimCoord-1)*3)+1, listRedHideImage, listGreenHideImage, listBlueHideImage);
       y = ceil(oneDimCoord / hideWidth);
       x = oneDimCoord - ((y - 1) * hideWidth);
       resultImage(y, x, 1) = resPix(1);
       resultImage(y, x, 2) = resPix(2);
       resultImage(y, x, 3) = resPix(3);

    end

    //Close waitbar
    close(bar);

endfunction

function retStruct = check_header(x, y, listHeadersHeight, listHeadersWidth, indexHeader, listCoordHeadersStart)
    for headerIndex=1 : size(listHeadersHeight(indexHeader))-(octSize-headerSize)
        strHeaderHeight = strHeaderHeight + string(listHeadersHeight(indexHeader)(headerIndex))
    end
   numHeaderHeight = bin2dec(strHeaderHeight);

   for headerIndex=1 : size(listHeadersWidth(indexHeader))-(octSize-headerSize)
       strHeaderWidth = strHeaderWidth + string(listHeadersWidth(indexHeader)(headerIndex))
   end
   numHeaderWidth = bin2dec(strHeaderWidth);

   if numHeaderHeight <= 0 || numHeaderWidth <= 0 || numHeaderHeight > heightHost || numHeaderWidth > widthHost || ~(octSize == size(listHeadersHeight(indexHeader))) || ~(octSize == size(listHeadersWidth(indexHeader))) then
        listHeadersHeight(indexHeader) = null();
        listHeadersWidth(indexHeader) = null();
        indexHeader = indexHeader - 1;
   else
      listCoordHeadersStart(indexHeader) = list(y,x);
   end
   retStruct.listHeadersHeight = listHeadersHeight;
   retStruct.listHeadersWidth = listHeadersWidth;
   retStruct.indexHeader = indexHeader + 1;
   retStruct.listCoordHeadersStart = listCoordHeadersStart;
   retStruct = resume(retStruct);
endfunction

function listStartImages = getListStartImages(coord)
    listStartImages = list();
    indexList = 1;
    x = coord(2);
    y  = coord(1);

    oneDimCoord = x + (widthHost * (y - 1));
    oneDimCoord = oneDimCoord + (octSize/(nbLSB-1));

    retCoord.y = ceil(oneDimCoord/widthHost);
    retCoord.x = oneDimCoord - ((retCoord.y - 1) * widthHost);

    listStartImages(indexList) = list(retCoord.y, retCoord.x);

    oneDimCoord = x + (widthHost * (y - 1));
    oneDimCoord = oneDimCoord + (octSize/(nbLSB-1));

    while %t
        indexList = indexList + 1;
        oneDimImageStart = oneDimCoord - (octSize/(nbLSB-1)) - (hideWidth * hideHeight);
        if oneDimImageStart > 0 then

            oneDimCoord = oneDimImageStart;
        else
            indexList = indexList - 1;
            break;
        end
        retCoord.y = ceil(oneDimCoord/widthHost);
        retCoord.x = oneDimCoord - ((retCoord.y - 1) * widthHost);
        listStartImages(indexList) = list(retCoord.y, retCoord.x);
    end

    oneDimCoord = x + (widthHost * (y - 1));
    oneDimCoord = oneDimCoord + (octSize/(nbLSB-1));

    while %t
        indexList = indexList + 1;
        oneDimImageStart = oneDimCoord + (hideWidth * hideHeight) + (octSize/(nbLSB-1));
        if oneDimImageStart <= (widthHost * heightHost) then
            oneDimCoord = oneDimImageStart;
        else
            indexList = indexList - 1;
            break;
        end
        retCoord.y = ceil(oneDimCoord/widthHost);
        retCoord.x = oneDimCoord - ((retCoord.y - 1) * widthHost);
        listStartImages(indexList) = list(retCoord.y, retCoord.x);
    end

    listStartImages = resume(listStartImages);
endfunction

function strETA = eta2string(eta)
   minETA = floor(eta/60);
   hETA = floor(minETA/60);
   jETA = floor(hETA/24);

   strETA = "";
   if jETA then
      jETAString = "days "
      if jETA < 2 then
        jETAString = "day "
      end
      strETA = strETA + string(jETA) + jETAString
   end
   if hETA then
       hETAString = " hours "
       if hETA < 2 then
         hETAString = " hour "
       end
      strETA = strETA + string(hETA) + hETA
   end
   if minETA then
       minETAString = " minutes "
       if minETA < 2 then
         minETAString = " minute "
       end
      strETA = strETA + string(minETA) + minETAString
      eta = modulo(eta,60);
   end
   sETAString = " seconds"
   if eta < 2 then
     sETAString = " second"
   end
   strETA = strETA + string(eta) + sETAString
endfunction

function pix = findPix(index, listRedHideImage, listGreenHideImage, listBlueHideImage)
    pix = list(0, 0, 0);
    for bitIndex=index : index+2
        rOne = 0;
        rZero = 0;
        gOne = 0;
        gZero = 0;
        bOne = 0;
        bZero = 0;
        for nbImage=1 : 2 : size(listRedHideImage(bitIndex))
            for comp=2 : 2 : size(listRedHideImage(bitIndex))
                if ~(listRedHideImage(bitIndex)(nbImage) == listRedHideImage(bitIndex)(comp)) then
                    if listRedHideImage(bitIndex)(nbImage) == 1 then
                      rOne = rOne + 1;
                   else
                      rZero = rZero + 1;
                   end
                end
                if ~(listGreenHideImage(bitIndex)(nbImage) == listGreenHideImage(bitIndex)(comp)) then
                   if listGreenHideImage(bitIndex)(nbImage) == 1 then
                      gOne = gOne + 1;
                   else
                      gZero = gZero + 1;
                   end
                end
                if ~(listBlueHideImage(bitIndex)(nbImage) == listBlueHideImage(bitIndex)(comp)) then
                   if listBlueHideImage(bitIndex)(nbImage) == 1 then
                      bOne = bOne + 1;
                   else
                      bZero = bZero + 1;
                   end
                end
            end
        end

        if ~(rOne == rZero) then
           if rOne > rZero then
               pix(1) = pix(1) + (2^(8-(bitIndex - index + 1)));
           end
        else
            sumBit = 0;
            for it=1 : size(listRedHideImage(bitIndex))
                if modulo(it, 2) == 0 then
                   if ~(listRedHideImage(bitIndex)(it)) then
                      sumBit = sumBit + 1;
                   else
                       sumBit = sumBit + 0;
                   end
                else
                   sumBit = sumBit + listRedHideImage(bitIndex)(it);
                end
            end
            if round(sumBit/size(listRedHideImage(bitIndex))) == 1 then
               pix(1) = pix(1) + 2^(8-(bitIndex - index + 1));
            end
        end
        if ~(gOne == gZero) then
           if gOne > gZero then
               pix(2) = pix(2) + 2^(8-(bitIndex - index + 1));
           end
        else
            sumBit = 0;
            for it=1 : size(listGreenHideImage(bitIndex))
                if modulo(it, 2) == 0 then
                   if ~(listGreenHideImage(bitIndex)(it)) then
                      sumBit = sumBit + 1;
                   else
                       sumBit = sumBit + 0;
                   end
                else
                   sumBit = sumBit + listGreenHideImage(bitIndex)(it);
                end
            end
            if round(sumBit/size(listGreenHideImage(bitIndex))) == 1 then
               pix(2) = pix(2) + 2^(8-(bitIndex - index + 1));
            end
        end
        if ~(bOne == bZero) then
           if bOne > bZero then
               pix(3) = pix(3) + 2^(8-(bitIndex - index + 1));
           end
        else
            sumBit = 0;
            for it=1 : size(listBlueHideImage(bitIndex))
                if modulo(it, 2) == 0 then
                   if ~(listBlueHideImage(bitIndex)(it)) then
                      sumBit = sumBit + 1;
                   else
                       sumBit = sumBit + 0;
                   end
                else
                   sumBit = sumBit + listBlueHideImage(bitIndex)(it);
                end
            end
            if round(sumBit/size(listBlueHideImage(bitIndex))) == 1 then
               pix(3) = pix(3) + 2^(8-(bitIndex - index + 1));
            end
        end
    end
    pix = resume(pix);
endfunction
