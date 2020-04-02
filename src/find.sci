//function[newBit] = hidebit(bit1,bit2,nbLSB)
//    newBit = bit1 - modulo(bit1,2^nbLSB) + floor(bit2/2^nbLSB)
//endfunction

function findImage(imageHost,nbLSB,nbImage)
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
    isCurrentHeader = 0;
    isCurrentHide = 0;

    //printf("size host %d\n", widthHide);

    for y=1 : heightHost
        printf("%d/%d\n", y, heightHost);
        for x=1 : widthHost
            //disp("test2 ", isCurrentHeader==1, bitget(imageHost(x,y,1),1) == bitHeader)
            if isCurrentHeader==1 && bitget(imageHost(x,y,1),1) == bitHeader then
                //disp("test3")
                for lsb=1 : nbLSB
                   listHeadersHeight(indexHeader)($+1) =  bitget(imageHost(x,y,1),lsb);
                   listHeadersWidth(indexHeader)($+1) =  bitget(imageHost(x,y,2),lsb);
                end
            else
                if isCurrentHeader==0 && bitget(imageHost(x,y,1),1) == bitHeader then
                    indexHeader = indexHeader + 1;
                    for lsb=1 : nbLSB
                       listHeadersHeight(indexHeader) =  list(bitget(imageHost(x,y,1), lsb));
                       listHeadersWidth(indexHeader) = list(bitget(imageHost(x,y,2), lsb));
                    end
                    isCurrentHeader = 1;
                    isCurrentHide = 0;
                end
            end

            if isCurrentHide==1 && bitget(imageHost(x,y,1),1) == bitHide then
                listRedHideImage(indexRGB)($+1) = bitget(imageHost(x,y,1),1);
                listGreenHideImage(indexRGB)($+1) = bitget(imageHost(x,y,2),1);
                listBlueHideImage(indexRGB)($+1) = bitget(imageHost(x,y,3),1);
            else
                if isCurrentHide==0 && bitget(imageHost(x,y,1),1) == bitHide then
                    indexRGB = indexRGB + 1;
                    listRedHideImage(indexRGB) = list(bitget(imageHost(x,y,1),1));
                    listGreenHideImage(indexRGB) = list(bitget(imageHost(x,y,2),1));
                    listBlueHideImage(indexRGB) = list(bitget(imageHost(x,y,3),1));
                    isCurrentHeader = 0;
                    isCurrentHide = 1;
                end
            end
        end
    end

    // Get header size
    hideHeight = uint32(0);
    one = 0;
    zero = 0;
    endIt = 0;

    disp(listHeadersHeight)
    for it=1 : heightHost
        if endIt == 1 then
           break;
        end
        for h=1 : size(listHeadersHeight)
            if it > size(listHeadersHeight(h)) then
                endIt = 1;
                break;
            end
            if listHeadersHeight(h)(it) == 0 then
              zero = zero + 1;
            else
              one = one + 1;
            end
        end
        if one > zero then
            disp("1")
            bitset(hideHeight, it, 1);
        else
            disp("0")
            bitset(hideHeight, it, 0);
        end
        one = 0;
        zero = 0;
    end

    hideWidth = uint32(0);
    one = 0;
    zero = 0;
    endIt = 0;

    for it=1 : widthHost
        if endIt == 1 then
           break;
        end
        for h=1 : size(listHeadersWidth)
            if it > size(listHeadersWidth(h)) then
                endIt = 1;
                break;
            end
            if listHeadersWidth(h)(it) == 0 then
              zero = zero + 1;
            else
              one = one + 1;
            end
        end
        if one > zero then
            bitset(hideWidth, it, 1);
        else
            bitset(hideWidth, it, 0);
        end
        one = 0;
        zero = 0;
    end

    //disp(hideHeight,"x",hideWidth)
    printf("%dx%d\n", hideHeight, hideWidth);


    // Comp Image Layer & Add to result image

    //resultImage = imresize(imageHost,sqrt(sizeHide*(widthHide/heightHide))/widthHide);
    //resultImage = imageHide;

endfunction
