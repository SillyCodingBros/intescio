//function[newBit] = hidebit(bit1,bit2,nbLSB)
//    newBit = bit1 - modulo(bit1,2^nbLSB) + floor(bit2/2^nbLSB)
//endfunction

function[resultImage] = findImage(imageHost,nbLSB,nbImage)
    heightHost = size(imageHost,1);
    widthHost = size(imageHost,2);

    bitHide = 0;
    bitHeader = 1;

    listHeadersHeight = list();
    listHeadersWidth = list();
    listRedHideImage = list();
    listGreenHideImage = list();
    listBlueHideImage = list();

    indexHeader = 0;
    indexRGB = 0;
    isCurrentHeader = %f;
    isCurrentHide = %f;

    percent = 0;
    tmp_percent = 0;

    //printf("size host %d\n", widthHide);

    for y=1 : heightHost
        tmp_percent = floor(y*100/heightHost);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("%d percent\n", percent);
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

    // Get header size
    hideHeight = 0; //uint32(0);
    one = 0;
    zero = 0;
    //endIt = %f;

    //disp(size(listHeadersHeight))
    //disp(size(listHeadersWidth))

    //disp(listHeadersHeight(1))
    //disp(listHeadersWidth(1))


    octSize = ceil(32/(nbLSB-1)) * (nbLSB-1);
    //disp(octSize);

    for it=1 : 32
        for h=1 : size(listHeadersHeight)
            if ~(octSize == size(listHeadersHeight(h))) then
                //endIt = %t;
                break;
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
                break;
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
    printf("%dx%d\n", hideHeight, hideWidth);

    // Comp Image Layer & Add to result image
    percent = 0;
    tmp_percent = 0;

    pix2get = hideHeight * hideWidth;
    one = 0;
    zero = 0;
    hidePix = 0;

    for y=1 : hideHeight
        tmp_percent = floor(y*100/hideHeight);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("%d percent\n", percent);
        end
        printf("%d/%d\n", y, hideHeight);
        for  x=1 : hideWidth
           for nbIter=1 : size(listRedHideImage)
                for c=1 : size(listRedHideImage(nbIter))
                   if c > pix2get then
                       break;
                   end
                   if modulo(c, (nbLSB-1)) == 0 then
                       hidePix = 0;
                   end
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
                   hidePix = hidePix + 2^(pos);
                end
                one = 0;
                zero = 0;
           end
           resultImage(y,x,1) = hidePix;
           one = 0;
           zero = 0;
           for nbIter=1 : size(listGreenHideImage)
                for c=1 : size(listGreenHideImage(nbIter))
                   if c > pix2get then
                       break;
                   end
                   if modulo(c, (nbLSB-1)) == 0 then
                       hidePix = 0;
                   end
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
           one = 0;
           zero = 0;
           for nbIter=1 : size(listBlueHideImage)
                for c=1 : size(listBlueHideImage(nbIter))
                   if c > pix2get then
                       break;
                   end
                   if modulo(c, (nbLSB-1)) == 0 then
                       hidePix = 0;
                   end
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
        end
    end

    //resultImage = imresize(imageHost,sqrt(sizeHide*(widthHide/heightHide))/widthHide);
    //resultImage = imageHide;

endfunction
