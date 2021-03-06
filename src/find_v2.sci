//function[newBit] = hidebit(bit1,bit2,nbLSB)
//    newBit = bit1 - modulo(bit1,2^nbLSB) + floor(bit2/2^nbLSB)
//endfunction

function[resultImage] = findImage(imageHost)
    nbLSB = 4;

    imageHost = im2uint8(imageHost);

    heightHost = size(imageHost,1);
    widthHost = size(imageHost,2);

    hideHeight = 0;
    hideWidth = 0;

    //resultImage=imageHost;

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

    octSize = ceil(32/(nbLSB-1)) * (nbLSB-1);

    lastHeaderX = 0;
    lastHeaderY = 0;

    // Waitbar
    bar = waitbar(0, "Step 1/3 - Finding Data...");

    //printf("size host %d\n", widthHide);
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
               //disp("test3")
               for lsb=2 : nbLSB
                  listHeadersHeight(indexHeader)($+1) = bitget(imageHost(y,x,1), lsb);
                  listHeadersWidth(indexHeader)($+1) = bitget(imageHost(y,x,2), lsb);

                  //listHeadersHeight(indexHeader) = listHeadersHeight(indexHeader) + ((2^(lsb-2)) * bitget(imageHost(y,x,1), lsb));
                  //listHeadersWidth(indexHeader) =  listHeadersWidth(indexHeader) + ((2^(lsb-2)) * bitget(imageHost(y,x,2), lsb));
               end
           end

           if ~isCurrentHeader && bitget(imageHost(y,x,1), 1) == bitHeader then
               //if x==1 then
                  //printf("%d:%d %d - %d \n", x, y, imageHost(y,x,1), bitget(imageHost(y,x,1), 1))
               //end

               indexHeader = indexHeader + 1;
               strHeaderHeight = ""
               strHeaderWidth = ""
               //printf("before check index = %d\n", indexHeader);
               if indexHeader > 1 then
                  //printf("Header ici %d\n", indexHeader-1)
                  retStruct = check_header(lastHeaderX, lastHeaderY, listHeadersHeight, listHeadersWidth, indexHeader-1, listCoordHeadersStart);
                  listHeadersHeight = retStruct.listHeadersHeight;
                  listHeadersWidth = retStruct.listHeadersWidth;
                  indexHeader = retStruct.indexHeader;
                  listCoordHeadersStart = retStruct.listCoordHeadersStart;
                  //printf("end check index = %d\n", indexHeader);
                  //sleep(1000)


                  //[1,1] = list2vec(listHeadersHeight(indexHeader-1));
                  //tmp = tmp + string();
                  //printf("%s\n", tmp);


               end
               for lsb=2 : nbLSB
                   //listHeadersHeight(indexHeader) = (2^(lsb-2)) * bitget(imageHost(y,x,1), lsb);
                   //listHeadersWidth(indexHeader) =  (2^(lsb-2)) * bitget(imageHost(y,x,2), lsb);

                   //listHeadersHeight(indexHeader) = bitset(listHeadersHeight(indexHeader),indexBitHeader,bitget(imageHost(y,x,1), lsb));
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
    //printf("list coord %d %d\n", listCoordHeadersStart(1)(1), listCoordHeadersStart(1)(2));
    printf("listCoordHeadersStart size = %d\n", size(listCoordHeadersStart));

    waitbar(100, "Step 1/3 - Processing...", bar);

    //listCoordEndHeaders = getHeaderEnds(listCoordHeadersStart(1));

    // Get header size Can Use Function rewrite
    hideHeight = 0; //uint32(0);
    one = 0;
    zero = 0;
    //endIt = %f;


    disp(size(listHeadersHeight))
    disp(size(listHeadersWidth))

    //disp(size(listHeadersHeight(1)))
    //disp(size(listHeadersWidth(1)))

    /*
    for x=1 : size(listHeadersHeight)
      printf("size list %d = %d\n", x, size(listHeadersHeight(x)))
    end

    for x=1 : size(listHeadersWidth)
      printf("size list %d = %d\n", x, size(listHeadersWidth(x)))
    end

    */

    //disp(listHeadersHeight(1))
    //disp(listHeadersWidth(1))

    //disp(octSize);
    count = 0
    for it=1 : 32
        for h=1 : size(listHeadersHeight)
            if ~(octSize == size(listHeadersHeight(h))) then
                //endIt = %t;
                continue;
            end

            if it == 1 then
                //disp(h);
               count = count + 1;
            end

            //disp(size(listHeadersWidth(h)));
            if listHeadersHeight(h)(it) == 0 then
              zero = zero + 1;
            else
              one = one + 1;
            end
        end
        //if endIt then
            //endIt = %f;
            //one = 0;
            //zero = 0;
            //break;
        //end
        //disp(one)
        //disp(zero)
        if one > zero then
            //disp("1")
            //hideHeight = bitset(hideHeight, it, 1);
            hideHeight = hideHeight + (2^(32 - it));
            //printf("hideHeight = %d px\n", hideHeight);
        //else
            //disp("0")
            //hideHeight = bitset(hideHeight, it, 0);
            //hideHeight = (2^(33 - it)) * 0 bitget(imageHost(y,x,1), 33 - it);
        end
        one = 0;
        zero = 0;
    end

    hideWidth = 0;//uint32(0);
    one = 0;
    zero = 0;
    //endIt = %f;

    for it=1 : 32
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
        //if endIt then
        //    endIt = %f;
        //    one = 0;
        //    zero = 0;
        //    break;
        //end
        if one > zero then
            //hideWidth = bitset(hideWidth, it, 1);
            hideWidth = hideWidth + (2^(32 - it));
            //printf("hideWidth = %d px\n", hideWidth);
            //disp("1")
        //else
            //hideWidth = bitset(hideWidth, it, 0);
            //disp("0")
        end
        one = 0;
        zero = 0;
    end

    //disp(hideHeight,"y",hideWidth)
    printf("count header ok %d\n", count);
    printf("hidden image %dx%d\n", hideHeight, hideWidth);

    //disp(listCoordHeadersStart)
    //disp(size(listCoordHeadersStart))

    if hideHeight > 0 && hideWidth > 0 && hideHeight <= heightHost && hideWidth <= widthHost then
       resultImage = imresize(imageHost, [hideHeight, hideWidth]);
       //Debug Return
       //resultImage = resume(resultImage);
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
    /*
    for itImage=1 : size(listStartImages)
        disp(listStartImages(itImage))
    end
    */

    for itImage=1 : size(listStartImages)

        //tmp_percent = floor(itImage*100/size(listStartImages));
        //waitbar(tmp_percent/100, "Step 2/3 - Finding Image "+string(itImage)+"/"+string(size(listStartImages)), bar);
        //if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            //percent = tmp_percent;
           //printf("Step 2/3 - Finding Images: %d percent\n", percent);
        //end

        heigthHideStart = listStartImages(itImage)(1);
        widthHideStart = listStartImages(itImage)(2);

        oneDimCoordStart = widthHideStart + (widthHost * (heigthHideStart - 1));
        oneDimCoordEnd = oneDimCoordStart + (hideWidth * hideHeight) - 1;

        //yEnd = ceil(oneDimCoordEnd/widthHost);
        //xEnd = oneDimCoordEnd - ((yEnd - 1) * widthHost);

        listRedHideImage(itImage) = list();
        listGreenHideImage(itImage) = list();
        listBlueHideImage(itImage) = list();

        //p_start = oneDimCoordStart;
        //p_end = oneDimCoordEnd;
        //p_dist_max = abs(p_end - p_start);

        //p_start = p_start - p_decal
        //p_end = p_end + p_decal
        //if p_start < 0 then
          // p_decal = ((-1)*p_start);
          // p_end = p_end + p_decal;
          // p_start = 0;
        //end

        //printf("p_dist_max = %d\n", p_dist_max);
        //printf("oneDimCoordStart = %d oneDimCoordEnd = %d\n", oneDimCoordStart, oneDimCoordEnd);

        tmp_percent = 0;
        percent = 0;
        svg = 0;
        eta = 0

        timer();

        for coord = oneDimCoordStart : oneDimCoordEnd
            //if coord < 1 then
            //p_dist = abs(p_end - coord);
            //end
            //if coord == oneDimCoordStart then
            //   printf("p_dist = %d p_dist_max = %d\n", p_dist, p_dist_max);
            //end

            //tmp_percent = floor(p_dist*100/p_dist_max);
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
                if y < 1 || y > heightHost || x < 1 || x > widthHost then
                    //disp("if\n")
                    listRedHideImage(itImage)($+1) = 1;
                    listGreenHideImage(itImage)($+1) = 1;
                    listBlueHideImage(itImage)($+1) = 1;
                    //disp("if pass\n")
                else
                    //disp("else\n")

                    y = ceil(coord/widthHost);
                    x = coord - ((y - 1) * widthHost);

                    listRedHideImage(itImage)($+1) = bitget(imageHost(y,x,1), lsb);
                    listGreenHideImage(itImage)($+1) = bitget(imageHost(y,x,2), lsb);
                    listBlueHideImage(itImage)($+1) = bitget(imageHost(y,x,3), lsb);
                    //disp("else pass\n")
                end
            end
        end
    end
/*
    for y=1 : heightHost
        tmp_percent = floor(y*100/heightHost);
        waitbar(tmp_percent/100, "Step 2/3 - Finding Images...", bar);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("Step 2/3 - Finding Images: %d percent\n", percent);
        end
        for x=1 : widthHost
            //disp("test2 ", isCurrentHeader==1, bitget(imageHost(y,x,1),1) == bitHeader)
            if isCurrentHeader && bitget(imageHost(y,x,1), 1) == bitHeader then
                //disp("test3")
                for lsb=2 : nbLSB
                   listHeadersHeight(indexHeader)($+1) = bitget(imageHost(y,x,1), lsb);
                   listHeadersWidth(indexHeader)($+1) = bitget(imageHost(y,x,2), lsb);

                   //listHeadersHeight(indexHeader) = listHeadersHeight(indexHeader) + ((2^(lsb-2)) * bitget(imageHost(y,x,1), lsb));
                   //listHeadersWidth(indexHeader) =  listHeadersWidth(indexHeader) + ((2^(lsb-2)) * bitget(imageHost(y,x,2), lsb));
                end
            else
                if ~isCurrentHeader && bitget(imageHost(y,x,1), 1) == bitHeader then
                    //if x==1 then
                       //printf("%d:%d %d - %d \n", x, y, imageHost(y,x,1), bitget(imageHost(y,x,1), 1))
                    //end
                    indexHeader = indexHeader + 1;
                    for lsb=2 : nbLSB
                        //listHeadersHeight(indexHeader) = (2^(lsb-2)) * bitget(imageHost(y,x,1), lsb);
                        //listHeadersWidth(indexHeader) =  (2^(lsb-2)) * bitget(imageHost(y,x,2), lsb);

                        //listHeadersHeight(indexHeader) = bitset(listHeadersHeight(indexHeader),indexBitHeader,bitget(imageHost(y,x,1), lsb));
                        if lsb==2 then
                           listHeadersHeight(indexHeader) = list(bitget(imageHost(y,x,1), lsb));
                           listHeadersWidth(indexHeader) = list(bitget(imageHost(y,x,2), lsb));
                        else
                           listHeadersHeight(indexHeader)($+1) = bitget(imageHost(y,x,1), lsb);
                           listHeadersWidth(indexHeader)($+1) = bitget(imageHost(y,x,2), lsb);
                        end
                    end
                    isCurrentHeader = %t;
                    isCurrentHide = %f;
                end
            end

            if isCurrentHide && bitget(imageHost(y,x,1), 1) == bitHide then
                for lsb=2 : nbLSB
                   listRedHideImage(indexRGB)($+1) = bitget(imageHost(y,x,1), lsb);
                   listGreenHideImage(indexRGB)($+1) = bitget(imageHost(y,x,2), lsb);
                   listBlueHideImage(indexRGB)($+1) = bitget(imageHost(y,x,3), lsb);
                end
            else
                if ~isCurrentHide && bitget(imageHost(y,x,1), 1) == bitHide then
                    indexRGB = indexRGB + 1;
                    for lsb=2 : nbLSB
                        if lsb==2 then
                           listRedHideImage(indexRGB) = list(bitget(imageHost(y,x,1), lsb));
                           listGreenHideImage(indexRGB) = list(bitget(imageHost(y,x,2), lsb));
                           listBlueHideImage(indexRGB) = list(bitget(imageHost(y,x,3), lsb));
                           //if indexRGB==1 then
                              //printf("first bit: %d\n", bitget(imageHost(y,x,1), lsb))
                           //end
                        else
                           listRedHideImage(indexRGB)($+1) = bitget(imageHost(y,x,1), lsb);
                           listGreenHideImage(indexRGB)($+1) = bitget(imageHost(y,x,2), lsb);
                           listBlueHideImage(indexRGB)($+1) = bitget(imageHost(y,x,3), lsb);
                        end
                    end
                    isCurrentHeader = %f;
                    isCurrentHide = %t;
                end
            end
        end
    end
*/
    // Comp Image Layer & Add to result image
    percent = 0;
    tmp_percent = 0;
    eta = 0;
    svg = 0;

    pix2get = hideHeight * hideWidth;
    one = 0;
    zero = 0;
    hidePix = 0;

    //disp(listRedHideImage)
    //disp('\n');
    //disp(listGreenHideImage)
    //disp('\n');
    //disp(listBlueHideImage)
    //disp('\n');

    waitbar(0, "Step 3/3 - Rebuilding Image...", bar);

    timer();

    for y=1 : hideHeight
        tmp_percent = floor(y*100/hideHeight);
        if ~(svg == tmp_percent) then
            time = timer();
            eta = floor((time/(tmp_percent-svg))*(100-tmp_percent))
        end

        svg = tmp_percent;

        waitbar(tmp_percent/100, "Step 3/3 - Rebuilding Image..."+" - ETA: "+eta2string(eta), bar);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("Step 3/3 - Rebuilding Image: %d percent\n", percent);
        end
        //printf("%d/%d\n", y, hideHeight);
        for  x=1 : hideWidth
           for c=(((x + (hideWidth * (y - 1))))*(nbLSB-1)) - (nbLSB-2) : ((x + (hideWidth * (y - 1))))*(nbLSB-1)
           //c=(x + (hideWidth * (y - 1)))
                if (c > pix2get*(nbLSB-1)) then
                   break;
                end
               //disp(c)
                for nbIter=1 : size(listRedHideImage)
                   if  c > size(listRedHideImage(nbIter)) then
                       break;
                   end
                   //if modulo(c-1, (nbLSB-1)) == 0 then
                    //   hidePix = 0;
                  // end
                   if listRedHideImage(nbIter)(c) == 1 then
                      one = one + 1;
                   else
                      zero = zero + 1;
                   end
                end
                if one > zero then
                    pos = 8-modulo(c, (nbLSB-1));
                    if pos == 8 then
                       pos = 5
                    end
                   hidePix = hidePix + (2^(pos));
                   //if c == 1 || c==2 || c==3 then
                    //  printf("hidePix: %d pos: %d value: %d", hidePix, pos, (2^(pos)))
                    //  disp(hidePix)
                   //end
                end
                one = 0;
                zero = 0;
           end
           //disp("\n");
           resultImage(y,x,1) = hidePix;
           one = 0;
           zero = 0;
           hidePix = 0;
           for c=(((x + (hideWidth * (y - 1))))*(nbLSB-1)) - (nbLSB-2) : ((x + (hideWidth * (y - 1))))*(nbLSB-1)
          // c=(x + (hideWidth * (y - 1)))
                for nbIter=1 : size(listGreenHideImage)
                   if (c > pix2get*(nbLSB-1)) || (c > size(listGreenHideImage(nbIter))) then
                       break;
                   end
                   //if modulo(c-1, (nbLSB-1)) == 0 then
                    //   hidePix = 0;
                   //end
                   if listGreenHideImage(nbIter)(c) == 1 then
                      one = one + 1;
                   else
                      zero = zero + 1;
                   end
                end
                if one > zero then
                    pos = 8-modulo(c, (nbLSB-1));
                    if pos == 8 then
                       pos = 5
                    end
                   hidePix = hidePix + 2^(pos);
                end
                one = 0;
                zero = 0;
           end
           resultImage(y,x,2) = hidePix;
           hidePix = 0;
           one = 0;
           zero = 0;
           for c=(((x + (hideWidth * (y - 1))))*(nbLSB-1)) - (nbLSB-2) : ((x + (hideWidth * (y - 1))))*(nbLSB-1)
           //c=(x + (hideWidth * (y - 1)))
                for nbIter=1 : size(listBlueHideImage)
                   if (c > pix2get*(nbLSB-1)) || (c > size(listBlueHideImage(nbIter))) then
                       break;
                   end
                   //if modulo(c-1, (nbLSB-1)) == 0 then
                    //   hidePix = 0;
                  // end
                   if listBlueHideImage(nbIter)(c) == 1 then
                      one = one + 1;
                   else
                      zero = zero + 1;
                   end
                end
                if one > zero then
                    pos = 8-modulo(c, (nbLSB-1));
                    if pos == 8 then
                       pos = 5
                    end
                   hidePix = hidePix + 2^(pos);
                end
                one = 0;
                zero = 0;
           end
           resultImage(y,x,3) = hidePix;
           hidePix = 0;
           one = 0;
           zero = 0;
        end
    end

    /*
    printf("pix2get : %d\n", pix2get)
    printf("listRedHideImage size : %d\n", size(listRedHideImage(1)))
    printf("listGreenHideImage size : %d\n", size(listGreenHideImage(1)))
    printf("listBlueHideImage size : %d\n", size(listBlueHideImage(1)))

    tmp = 0;
    tmp2 = 0;
    for x=1 : size(listRedHideImage(1))
       printf("%d", listRedHideImage(1)(x))
       if modulo(x, 3) == 0 then
          printf(" ")
          tmp = tmp + 1;
       end
       if modulo(tmp, 16) == 0 && ~(tmp == tmp2) then
          printf("\n")
          tmp2 = tmp;
       end
    end
    printf("\n")
    */

    //resultImage = im2uint8(resultImage);

    //Close waitbar
    close(bar);

    //disp(listRedHideImage(1))

endfunction

function retStruct = check_header(x, y, listHeadersHeight, listHeadersWidth, indexHeader, listCoordHeadersStart)
    //disp("bonjour\n");
    //printf("check args %d:%d %d\n", x, y, indexHeader)
   for headerSize=1 : size(listHeadersHeight(indexHeader))-1
     strHeaderHeight = strHeaderHeight + string(listHeadersHeight(indexHeader)(headerSize))
   end
   numHeaderHeight = bin2dec(strHeaderHeight);

   for headerSize=1 : size(listHeadersWidth(indexHeader))-1
     strHeaderWidth = strHeaderWidth + string(listHeadersWidth(indexHeader)(headerSize))
   end
   numHeaderWidth = bin2dec(strHeaderWidth);

   //printf("dim %d:%d\n", numHeaderWidth, numHeaderHeight)

   /*
   if numHeaderHeight <= 0 || numHeaderWidth <= 0 then
      printf("header height out of range\n");
   end

   if numHeaderHeight > heightHost || numHeaderWidth > widthHost then
      printf("header bigger than host\n");
   end

   if ~(octSize == size(listHeadersHeight(indexHeader))) || ~(octSize == size(listHeadersWidth(indexHeader))) then
      printf("Wrong size\n");
      printf("sizeH = %d sizeW = %d\n", size(listHeadersHeight(indexHeader)), size(listHeadersWidth(indexHeader)));
   end
   */

   if numHeaderHeight <= 0 || numHeaderWidth <= 0 || numHeaderHeight > heightHost || numHeaderWidth > widthHost || ~(octSize == size(listHeadersHeight(indexHeader))) || ~(octSize == size(listHeadersWidth(indexHeader))) then
     //printf("supp %d\n",  numHeaderHeight);
     listHeadersHeight(indexHeader) = null();
     listHeadersWidth(indexHeader) = null();
     indexHeader = indexHeader - 1;
   else

      listCoordHeadersStart(indexHeader) = list(y,x);
      //printf("coord %d %d\n", x,y);

     printf("height %d - %s\n", numHeaderHeight, strHeaderHeight);
     printf("width %d - %s\n", numHeaderWidth, strHeaderWidth);
     //sleep(1500);
   end
   retStruct.listHeadersHeight = listHeadersHeight;
   retStruct.listHeadersWidth = listHeadersWidth;
   retStruct.indexHeader = indexHeader + 1;
   retStruct.listCoordHeadersStart = listCoordHeadersStart;
   //disp(listCoordHeadersStart);
   retStruct = resume(retStruct);
endfunction

function listStartImages = getListStartImages(coord)
    listStartImages = list();
    indexList = 1;
    x = coord(2);
    y  = coord(1);

    printf("header start coord %d:%d\n", x, y);

    oneDimCoord = x + (widthHost * (y - 1));
    oneDimCoord = oneDimCoord + (octSize/(nbLSB-1));

    retCoord.y = ceil(oneDimCoord/widthHost);
    retCoord.x = oneDimCoord - ((retCoord.y - 1) * widthHost);

    printf("image start coord %d:%d\n", retCoord.x, retCoord.y);

    listStartImages(indexList) = list(retCoord.y, retCoord.x);

    oneDimCoord = x + (widthHost * (y - 1));
    oneDimCoord = oneDimCoord + (octSize/(nbLSB-1));

    disp(oneDimCoord);

    while %t
        indexList = indexList + 1;
        oneDimImageStart = oneDimCoord - (octSize/(nbLSB-1)) - (hideWidth * hideHeight);
        if (oneDimCoord - (octSize/(nbLSB-1)) - 1) > 0 then
            oneDimCoord = oneDimImageStart;
        else
            indexList = indexList - 1;
            break;
        end
        retCoord.y = ceil(oneDimCoord/widthHost);
        retCoord.x = oneDimCoord - ((retCoord.y - 1) * widthHost);
        printf("pre add image start %d:%d\n",retCoord.x, retCoord.y);
        listStartImages(indexList) = list(retCoord.y, retCoord.x);
    end

    oneDimCoord = x + (widthHost * (y - 1));
    oneDimCoord = oneDimCoord + (octSize/(nbLSB-1));

    while %t
        indexList = indexList + 1;
        oneDimImageStart = oneDimCoord + (hideWidth * hideHeight) + (octSize/(nbLSB-1));
        //if (oneDimImageStart + (hideWidth * hideHeight) - 1 <= (widthHost * heightHost)) then
        if oneDimImageStart <= (widthHost * heightHost) then
            oneDimCoord = oneDimImageStart;
        else
            indexList = indexList - 1;
            break;
        end
        retCoord.y = ceil(oneDimCoord/widthHost);
        retCoord.x = oneDimCoord - ((retCoord.y - 1) * widthHost);
        printf("post add image start %d:%d\n", retCoord.x, retCoord.y);
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