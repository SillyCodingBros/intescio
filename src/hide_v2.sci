function[resultImage] = hideImage(imageHost,imageHide)

    nbLSB = 4;
/*
    nbImage = ceil((size(imageHost,1)*size(imageHost,2))/(size(imageHide,1)*size(imageHide,2)+ceil(32/(nbLSB-1))));
    if nbImage == 0 then
        nbImage = 1
    end
*/
    imageHost = im2uint8(imageHost);
    heightHost = size(imageHost,1);
    widthHost = size(imageHost,2);

    imageHide = im2uint8(imageHide);
    heightHide = size(imageHide,1);
    widthHide = size(imageHide,2);

    header = [uint32(widthHide),uint32(heightHide)];

    //sizeHide = (heightHide*widthHide+ceil(32/(nbLSB-1)))*nbImage;

    isHeader = %t;
    //hideEnd = %f;
    bitHeader = 1;
    indexImageHide = 1;
/*
    coef = ceil(sqrt(sizeHide*(widthHost/heightHost)))/widthHost;
    if coef < 1 then
       coef = 1;
    end
*/
    //resultImage = imresize(imageHost,coef);
    resultImage = imageHost;
    heightResultImage = size(resultImage,1);
    widthResultImage = size(resultImage,2);
    //im_write_count = 0;

    // Waitbar
    percent = 0;
    tmp_percent = 0;
    svg = 0;
    eta = 0;
    bar = waitbar(0, "Hiding Data...");

    timer();

    for y=1 : heightResultImage
        //if nbImage == 0 then
           //break;
        //end
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
            //if nbImage == 0 then
               //break;
            //end
            for layer=1 : size(resultImage,3)
                if isHeader && modulo(resultImage(y,x,layer), uint8(2)) == 0 then
                    resultImage(y,x,layer) = resultImage(y,x,layer) + 1;
                    //disp(imageResult(y,x,layer), 'imageResult header was even');
                end
                if ~isHeader && ~(modulo(resultImage(y,x,layer), uint8(2)) == 0) then
                   resultImage(y,x,layer) = resultImage(y,x,layer) - 1;
                   //disp(imageResult(y,x,layer), 'imageResult');
                end
            end

            if ~isHeader /*&& ~hideEnd*/ then
                /*if nbImage > 0 then*/
                   for layer=1 : size(resultImage,3)
                       if layer <= size(imageHide,3) then
                           //resultImage(y,x,layer) = bitset(resultImage(y,x,layer), bit, bitget(imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer),9-bit))
                           //if layer == 1 then
                            //printf("%d <-- %d\n", resultImage(y,x,layer), imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer))
                           //end
                           resultImage(y,x,layer) = hiding_val(resultImage(y,x,layer), imageHide(ceil(indexImageHide/widthHide),modulo(indexImageHide-1,widthHide)+1,layer), nbLSB);
                           //if layer == 1 then
                            //printf("res = %d\n", resultImage(y,x,layer))
                           //end

                       end
                   end
                /*end*/

                indexImageHide = indexImageHide+1;
                if indexImageHide > widthHide*heightHide then
                    indexImageHide = 1;
                    isHeader = %t;
                    /*
                    nbImage = nbImage - 1;
                    if nbImage > 0 then
                       isHeader = %t;
                    else
                        hideEnd = %t;
                    end
                    */
                    continue;
                end
            end

            if isHeader /*&& ~hideEnd*/ then
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
                            resultImage(y,x,1) = bitset(resultImage(y,x,1), bit, bitget(heightHide,33-bitHeader));
                            resultImage(y,x,2) = bitset(resultImage(y,x,2), bit, bitget(widthHide,33-bitHeader));
                            //printf("\n%d:%d - ",x,y)
                            //printf("bitheader = %d - ", bitHeader)
                            //printf("bitget = %d", bitget(heightHide,33-bitHeader))
                            bitHeader = bitHeader+1;
                            if bitHeader > 32 then
                                //printf("\n%d %d header = %d\n", x, y, resultImage(y,x,1))
                                bitHeader = 1;
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
