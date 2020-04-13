function[resultImage] = hideImage(imageHost,imageHide)

    nbLSB = 4;

    if size(imageHost, 3) == 1 then
       layer = im2uint8(imageHost);
       tmpHost(:,:,1) = layer;
       tmpHost(:,:,2) = layer;
       tmpHost(:,:,3) = layer;
       imageHost = tmpHost;
    end

    if size(imageHide, 3) == 1 then
       layer = im2uint8(imageHide);
       tmpHide(:,:,1) = layer;
       tmpHide(:,:,2) = layer;
       tmpHide(:,:,3) = layer;
       imageHide = tmpHide;
    end

    imageHost = im2uint8(imageHost);
    imageHide = im2uint8(imageHide);
    heightHost = size(imageHost,1);
    widthHost = size(imageHost,2);

    imageHide = im2uint8(imageHide);
    heightHide = size(imageHide,1);
    widthHide = size(imageHide,2);

    isInvert = %f;
    image2Hide = imageHide;

    imageHideInvert = imageHide;

    for y=1 : size(imageHideInvert,1)
       for x=1 : size(imageHideInvert,2)
          for l=1 : size(imageHideInvert,3)
             imageHideInvert(y,x,l) = 255 - imageHideInvert(y,x,l);
          end
       end
    end

    header = [uint32(widthHide),uint32(heightHide)];

    n = 2;
    coef = sqrt((n*(widthHide*heightHide))/(heightHost*widthHost));
    if coef < 1 then
       coef = 1;
    end
    //printf("debug coeff = %d\n",coef);

    resultImage = imresize(imageHost,coef);
    if size(resultImage,3) == 4 then
        tmpResult(:,:,1) = resultImage(:,:,1);
        tmpResult(:,:,2) = resultImage(:,:,2);
        tmpResult(:,:,3) = resultImage(:,:,3);
        resultImage = tmpResult;
    end

    heightResultImage = size(resultImage,1);
    widthResultImage = size(resultImage,2);
/*
    if widthHost < heightHost then
       headerSize = length(dec2bin(heightResultImage));
    else
       headerSize = length(dec2bin(widthResultImage));
    end
*/
    headerSize = 16;

    isHeader = %t;
    bitHeader = headerSize;
    indexImageHide = 1;

    // Waitbar
    percent = 0;
    tmp_percent = 0;
    svg = 0;
    eta = 0;
    bar = waitbar(0, "Hiding Data...");

    timer();

    for y=1 : heightResultImage

        tmp_percent = floor(y*100/heightResultImage);
        if ~(svg == tmp_percent) then
            time = timer();
            eta = floor((time/(tmp_percent-svg))*(100-tmp_percent))
        end

        svg = tmp_percent;

        waitbar(tmp_percent/100, "Hiding Data..."+" - ETA: "+eta2string(eta), bar);
        if ~(tmp_percent == percent) && modulo(tmp_percent, 10) == 0 then
            percent = tmp_percent;
           printf("Hiding Data: %d percent\n", percent);
        end
        //printf("y=%d/%d\n",y,heightResultImage)
        for x=1 : widthResultImage

            for layer=1 : 3//size(resultImage,3)
                if isHeader && modulo(resultImage(y,x,layer), uint8(2)) == 0 then
                    resultImage(y,x,layer) = resultImage(y,x,layer) + 1;
                    //disp(imageResult(y,x,layer), 'imageResult header was even');
                end
                if ~isHeader && ~(modulo(resultImage(y,x,layer), uint8(2)) == 0) then
                   resultImage(y,x,layer) = resultImage(y,x,layer) - 1;
                   //disp(imageResult(y,x,layer), 'imageResult');
                end
            end

            if ~isHeader then
                /*if nbImage > 0 then*/
                   for layer=1 : 3//size(resultImage,3)
                       //if layer <= size(image2Hide,3) then
                           //resultImage(y,x,layer) = bitset(resultImage(y,x,layer), bit, bitget(imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer),9-bit))
                           //if layer == 1 then
                            //printf("%d <-- %d\n", resultImage(y,x,layer), imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer))
                           //end
                        resultImage(y,x,layer) = hiding_val(resultImage(y,x,layer), image2Hide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer), nbLSB);
                           //if layer == 1 then
                            //printf("res = %d\n", resultImage(y,x,layer))
                           //end

                       //end
                   end
                /*end*/

                indexImageHide = indexImageHide+1;
                if indexImageHide > widthHide*heightHide then
                    indexImageHide = 1;
                    isHeader = %t;
                    if isInvert then
                       isInvert = %f
                       image2Hide = imageHide;
                    else
                       isInvert = %t
                       image2Hide = imageHideInvert;
                    end
                    continue;
                end
            end

            if isHeader then
                //printf("\n%d:%d\n",x,y)
                for bit=2 : nbLSB
                    //if bit == 1 /*|| nbImage <= 0*/ then
                        //for layer=1 : size(resultImage,3)
                        //    resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,1)
                        //end

                    //else
                        //if ~isHeader then
                        //    disp("possible?")
                        //    for layer=1 : size(resultImage,3)
                        //        resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,0)
                        //    end
                        //else
                            resultImage(y,x,1) = bitset(resultImage(y,x,1), bit, bitget(heightHide,bitHeader));
                            resultImage(y,x,2) = bitset(resultImage(y,x,2), bit, bitget(widthHide,bitHeader));
                            //printf("\n%d:%d - ",x,y)
                            //printf("bitheader = %d - ", bitHeader)
                            //printf("bitget = %d", bitget(heightHide,33-bitHeader))
                            bitHeader = bitHeader-1;
                            if bitHeader < 1 then
                                //printf("\n%d %d header = %d\n", x, y, resultImage(y,x,1))
                                bitHeader = headerSize;
                                isHeader = %f;
                                break;
                            end
                        //end
                    //end
                //else
                    //if bit == 1 then
                    //    for layer=1 : size(resultImage,3)
                    //        resultImage(y,x,layer) = bitset(resultImage(y,x,layer),bit,0)
                    //    end
                    //else
                        //for layer=1 : size(resultImage,3)
                        //    if layer <= size(imageHide,3) then
                                //resultImage(y,x,layer) = bitset(resultImage(y,x,layer), bit, bitget(imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer),9-bit))
                        //        resultImage(y,x,layer) = hiding_val(resultImage(y,x,layer), imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer))
                        //    end
                        //end
                    //end
                end
            end
        end
    end

    //Close Waitbar
    close(bar);


endfunction

function res_val = hiding_val(host_val, hide_val, nbLSB)
   //printf("\n")
   res_val = host_val;
   res_val = bitset(host_val, 1, 0);
   for x=2 : nbLSB
      res_val = bitset(res_val, x, bitget(hide_val,10-x))
      //printf("x=%d : res_val = %d\n",x,res_val)
      //print_binary(res_val)
      //printf("\n")
   end
   //printf("\n\nhiding_val : res_val = %d\n", res_val)
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
