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

    //printf("size hide = %d\n",sizeHide)
    //printf("size new host = %d\n",ceil(sqrt(sizeHide*(widthHost/heightHost))))
    //printf("size host %d\n", widthHost)
    printf("coeff = %f\n",coef)

    if coef < 1 then
       coef = 1
    end
    resultImage = imresize(imageHost,coef)
    heightResultImage = size(resultImage,1)
    widthResultImage = size(resultImage,2)

    for y=1 : heightResultImage
        printf("y=%d/%d\n",y,heightResultImage)
        for x=1 : widthResultImage
            for bit=1 : nbLSB
                //printf("y=%d/%d x=%d/%d bit=%d\n",y,heightResultImage,x,widthResultImage,bit)
                if isHeader then
                    //printf("in header index = %d/32\n",bitHeader)
                    if bit == 1 then
                        //printf("delimiteur\n")
                        for layer=1 : size(resultImage,3)
                            //printf("old bit = %d ",bitget(resultImage(y,x,layer),bit))
                            //printf("replace bit = 1 ")
                            resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,1)
                            //printf("new bit = %d\n",bitget(resultImage(y,x,layer),bit))
                        end
                    else
                        //printf("header\n")
                        resultImage(y,x,1) = bitset(resultImage(y,x,1),bit,bitget(heightHide,bitHeader))
                        resultImage(y,x,2) = bitset(resultImage(y,x,2),bit,bitget(widthHide,bitHeader))
                        bitHeader = bitHeader+1
                        if bitHeader > 32 then
                            bitHeader = 1
                            isHeader = %f
                        end
                    end
                else
                    //printf("in image index = %d/%d\n",indexImageHide,widthHide*heightHide)
                    if bit == 1 then
                        //printf("delimiteur\n")
                        for layer=1 : size(resultImage,3)
                            //printf("old bit = %d ",bitget(resultImage(y,x,layer),bit))
                            //printf("replace bit = 0 ")
                            resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,0)
                            //printf("new bit = %d\n",bitget(resultImage(y,x,layer),bit))
                        end
                    else
                        //printf("image\n")
                        for layer=1 : size(resultImage,3)
                            //printf("old bit = %d ",bitget(resultImage(y,x,layer),bit))
                            //printf("replace bit = %d ",bitget(imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer),9-bit))
                            resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,bitget(imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer),9-bit))
                            //printf("new bit = %d\n",bitget(resultImage(y,x,layer),bit))
                        end
                    end
                end
            end
            if ~isHeader then
                indexImageHide = indexImageHide+1
                if indexImageHide > widthHide*heightHide then
                    indexImageHide = 1
                    //printf("new image\n")
                    nbImage = nbImage - 1
                    if nbImage <= 0 then
                        //printf("fin\n")
                       return
                    end
                    isHeader = %t
                end
            end
        end
    end
endfunction
