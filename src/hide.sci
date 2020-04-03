function imageResult = hideImage(imageHost,imageHide,nbLSB,nbImage)

    heightImageHide = size(imageHide,1);
    widthImageHide = size(imageHide,2);
    layerImageHide = size(imageHide,3);

    heightImageHost = size(imageHost,1);
    widthImageHost = size(imageHost,2);
    layerImageHost = size(imageHost,3);

    coef = ceil(sqrt(((heightImageHide*widthImageHide+ceil(32/(nbLSB-1)))*nbImage)*(widthImageHost/heightImageHost)))/widthImageHost;
    if coef < 1 then
       coef = 1;
    end

    imageResult = imresize(imageHost,coef);

    heightImageResult = size(imageResult,1);
    widthImageResult = size(imageResult,2);
    layerImageResult = size(imageResult,3);

    isHeader = %t
    bitHeader = 1
    indexImageHide = 1

    percent = 0;
    tmp_percent = 0;

    for y=1 : heightImageResult

        tmp_percent = floor(y*100/heightImageResult);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("Hiding Data: %d percent\n", percent);
        end

        for x=1 : widthImageResult
            if isHeader then
                for layer=1 : layerImageResult
                    imageResult(y,x,layer) = setbit(imageResult(y,x,layer),1,1)
                end
            else
                for layer=1 : layerImageResult
                    imageResult(y,x,layer) = setbit(imageResult(y,x,layer),1,0)
                end
            end
            for bit=2 : nbLSB
                if isHeader then
                    imageResult(y,x,1) = setbit(imageResult(y,x,1),bit,bitget(heightImageHide,33-bitHeader))
                    imageResult(y,x,2) = setbit(imageResult(y,x,2),bit,bitget(widthImageHide,33-bitHeader))
                    bitHeader = bitHeader+1
                    if bitHeader > 32 then
                        bitHeader = 1
                        isHeader = %f
                    end
                else
                    for layer=1 : layerImageResult
                        if layer <= size(imageHide,3) then
                            imageResult(y,x,layer) = setbit(imageResult(y,x,layer),bit,bitget(imageHide(ceil(indexImageHide/widthImageHide),modulo(indexImageHide-1,widthImageHide)+1,layer),10-bit))
                        end
                    end
                end
            end
            if ~isHeader then
                indexImageHide = indexImageHide+1
                if indexImageHide > widthImageHide*heightImageHide then
                    indexImageHide = 1
                    nbImage = nbImage - 1
                    isHeader = %t
                end
            end
        end
    end

endfunction

function newVal = setbit(source,pos,value)
    newVal = (source - modulo(source,uint8(2^(pos-value)))) + modulo(source,uint8(2^(pos-1)))
endfunction

function debugImage = testFindRes(image,nbClear)
    height = size(image,1);
    width = size(image,2);
    layer = size(image,3);

    for l=1 : layer
        for y=1 : height
            for x=1 : width
                for bit=1 : 8
                    if bit <= nbClear then
                        image(y,x,l) = setbit(image(y,x,l),bit,0);
                    end
                end
            end
        end
    end

    debugImage = image;

endfunction

function debugPBI(image,nbSep)
    height = size(image,1);
    width = size(image,2);
    layer = size(image,3);

    for l=1 : layer
        printf("layer %d\n",l);
        for y=1 : height
            for x=1 : width
                for bit=1 : 8
                    if 9-bit == nbSep then
                        printf(" ");
                    end
                    printf("%d", bitget(image(y,x,l),9-bit));
                end
                printf("  ");
            end
            printf("\n");
        end
        printf("\n");
    end
endfunction
