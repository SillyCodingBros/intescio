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
    isCurrentHeader = %f;
    isCurrentHide = %f;

    //printf("size host %d\n", widthHide);

    for y=1 : heightHost
        printf("%d/%d\n", y, heightHost);
        for x=1 : widthHost
            //disp("test2 ", isCurrentHeader==1, bitget(imageHost(x,y,1),1) == bitHeader)
            if isCurrentHeader && bitget(imageHost(x,y,1), 1) == bitHeader then
                //disp("test3")
                for lsb=2 : nbLSB
                   listHeadersHeight(indexHeader)($+1) =  bitget(imageHost(x,y,1), lsb);
                   listHeadersWidth(indexHeader)($+1) =  bitget(imageHost(x,y,2), lsb);
                end
            else
                if ~isCurrentHeader && bitget(imageHost(x,y,1), 1) == bitHeader then
                    indexHeader = indexHeader + 1;
                    for lsb=2 : nbLSB
                       listHeadersHeight(indexHeader) =  list(bitget(imageHost(x,y,1), lsb));
                       listHeadersWidth(indexHeader) = list(bitget(imageHost(x,y,2), lsb));
                    end
                    isCurrentHeader = %t;
                    isCurrentHide = %f;
                end
            end

            if isCurrentHide && bitget(imageHost(x,y,1), 1) == bitHide then
                for lsb=2 : nbLSB
                   listRedHideImage(indexRGB)($+1) = bitget(imageHost(x,y,1), lsb);
                   listGreenHideImage(indexRGB)($+1) = bitget(imageHost(x,y,2), lsb);
                   listBlueHideImage(indexRGB)($+1) = bitget(imageHost(x,y,3), lsb);
                end
            else
                if ~isCurrentHide && bitget(imageHost(x,y,1), 1) == bitHide then
                    indexRGB = indexRGB + 1;
                    for lsb=2 : nbLSB
                       listRedHideImage(indexRGB) = list(bitget(imageHost(x,y,1), lsb));
                       listGreenHideImage(indexRGB) = list(bitget(imageHost(x,y,2), lsb));
                       listBlueHideImage(indexRGB) = list(bitget(imageHost(x,y,3), lsb));
                    end
                    isCurrentHeader = %f;
                    isCurrentHide = %t;
                end
            end
        end
    end

    // Get header size
    hideHeight = uint32(0);
    one = 0;
    zero = 0;
    endIt = %f;

    disp(size(listHeadersHeight))
    disp(size(listHeadersWidth))

    octSize = ceil(32/(nbLSB-1)) * (nbLSB-1);
    disp(octSize);

    for it=1 : 32
        for h=1 : size(listHeadersHeight)
            if ~(octSize == size(listHeadersHeight(h))) then
                endIt = %t;
                break;
            end
            disp(size(listHeadersWidth(h)));
            if listHeadersHeight(h)(it) == 0 then
              zero = zero + 1;
            else
              one = one + 1;
            end
        end
        if endIt then
            endIt = %f;
            one = 0;
            zero = 0;
            break;
        end
        if one > zero then
            disp("1")
            hideHeight = bitset(hideHeight, it, 1);
        else
            disp("0")
            //hideHeight = bitset(hideHeight, it, 0);
        end
        one = 0;
        zero = 0;
    end

    hideWidth = uint32(0);
    one = 0;
    zero = 0;
    endIt = %f;

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
        if endIt then
            endIt = %f;
            one = 0;
            zero = 0;
            break;
        end
        if one > zero then
            hideWidth = bitset(hideWidth, it, 1);
            disp("1")
        else
            //hideWidth = bitset(hideWidth, it, 0);
            disp("0")
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
