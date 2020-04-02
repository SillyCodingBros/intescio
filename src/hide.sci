function[resultImage] = hideImage(imageHost,imageHide,nbLSB,nbImage)
    heightHost = size(imageHost,1)
    widthHost = size(imageHost,2)

    heightHide = size(imageHide,1)
    widthHide = size(imageHide,2)

    header = [uint32(widthHide),uint32(heightHide)]

    sizeHide = (heightHide*widthHide+ceil(32/(nbLSB-1)))*nbImage

    isHeader = %t
    bitHeader = 1
    indexImageHide = 1

    coef = ceil(sqrt(sizeHide*(widthHost/heightHost)))/widthHost

    percent = 0;
    tmp_percent = 0;

    if coef < 1 then
       coef = 1
    end
    resultImage = imresize(imageHost,coef)
    heightResultImage = size(resultImage,1)
    widthResultImage = size(resultImage,2)

    for y=1 : heightResultImage
        tmp_percent = floor(y*100/heightResultImage);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("Hiding Data: %d percent\n", percent);
        end
        //printf("y=%d/%d\n",y,heightResultImage)
        for x=1 : widthResultImage
            for bit=1 : nbLSB
                if isHeader then
                    if bit == 1 || nbImage <= 0 then
                        for layer=1 : size(resultImage,3)
                            resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,1)
                        end
                    else
                        if ~isHeader then
                            for layer=1 : size(resultImage,3)
                                resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,0)
                            end
                        else
                            resultImage(y,x,1) = bitset(resultImage(y,x,1),bit,bitget(heightHide,33-bitHeader))
                            resultImage(y,x,2) = bitset(resultImage(y,x,2),bit,bitget(widthHide,33-bitHeader))
                            bitHeader = bitHeader+1
                            if bitHeader > 32 then
                                bitHeader = 1
                                isHeader = %f
                            end
                        end
                    end
                else
                    if bit == 1 then
                        for layer=1 : size(resultImage,3)
                            resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,0)
                        end
                    else
                        for layer=1 : size(resultImage,3)
                            if layer <= size(imageHide,3) then
                                resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,bitget(imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer),9-bit))
                            end
                        end
                    end
                end
            end
            if ~isHeader then
                indexImageHide = indexImageHide+1
                if indexImageHide > widthHide*heightHide then
                    indexImageHide = 1
                    nbImage = nbImage - 1
                    isHeader = %t
                end
            end
        end
    end
endfunction
