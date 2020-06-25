#EEE4120F YODA Project - Image Steganography Decoder
#Derick Nyende | Tatenda Shuro | Kai Brown
#NYNDER001 | SHRTAT001 | BRWKAI001
#Created: 24/06/2020
#Program to load a .jpg image from memory, decode a secret message into the lsb
#of the RGB data, and save the encoded image to the disc.

#-----------------First time package installation:-----------------------
#Pkg.add("Images")
#Pkg.add("TestImages")
#Pkg.add("Colors")
#Pkg.add("Plots")

#--------------------------------Libraries:-------------------------------
using Images, TestImages, Colors, Plots

#--------------------------------Create Message:--------------------------
message = "The turkey has left the oven, I repeat, THE TURKEY HAS LEFT THE OVEN!"
message = Vector{UInt8}(message) #array of ascii values
msgE = Vector{UInt8}()          #Array of bits of the ascii values
for z in message
    append!(msgE, reverse([z & (0x1<<n) != 0 for n in 0:7]))
end

#-------------------------Retrieve Image Data:---------------------------
imgO = load("YODA_image_original.jpg")
imgG = rawview(channelview(Gray.(imgO)))
save("YODA_image_original_grey.jpg", imgG)

#------------------------Encode Message:---------------------------------
function encode(imgArr, msg)
    i = 1   #counter for encoding progress
    mlen = size(msg)[1] #Length of secret message in bits
    n, m = size(imgArr); #Dimensions of Image

    for h in 1:n
        for w in 1:m    #loop through pixels
            lsb = UInt8(imgArr[h, w]%2);  #lsb of each pixel
            if i <= mlen                #still encoding
                if msg[i]==1 & lsb==0
                    imgArr[h, w] += 1;
                elseif msg[i]==1 & lsb==0
                    imgArr[h, w] -= 1;
                else
                    continue            #pixel lsb and msgE[1] equal
                end
            else                        #Past msg length, clear lsb
                if lsb==1
                    imgArr[h, w] -= 1;
                end
            end
            i += 1
        end
    end
    return imgArr
end

imgE = encode(imgG, msgE);

#-----------------------Save Encoded Image:----------------------------
save("YODA_image_encoded.jpg", imgE)

#----------------------Decode Message:---------------------------------
function decode(imgArr)
    n, m = size(imgArr); #Dimensions of Image
    msg = Vector{UInt8}(); #Array of bits of the ascii values
    message2 = Vector{UInt8}(); #ASCII Values of the message

    #retrieve data from message
    for h in 1:n
        for w in 1:m    #loop through pixels
            lsb = UInt8(imgArr[h, w]%2);  #lsb of each pixel
            append!(msg, lsb);          #add lsb to decoded message
        end
    end

    #convert data to text

    mlen = size(msg)[1] #Length of secret message in bits
    for i in UInt8(1):UInt32(mlen/8) #loop for each byte in message2
        append!(message2, UInt8(0));
        for j in 1:8    #loop for each bit in each byte
            message2[i] += (msg[8*(i-1) + j] << (8 - j));
        end
    end
    msg = String(msg);
    return msg
end

message2 = decode(imgE);
println(message2);
