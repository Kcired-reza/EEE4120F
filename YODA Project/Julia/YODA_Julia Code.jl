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
msgE = BitVector()
for z in message
    append!(msgE, reverse([z & (0x1<<n) != 0 for n in 0:7]))
end
mlen = size(msgE)[1]

#-------------------------Retrieve Image Data:---------------------------
imgO = load("YODA_image_original.jpg")
imgE = rawview(channelview(Gray.(imgO)))
save("YODA_image_original_grey.jpg", imgE)
n, m = size(imgE);

#------------------------Encode Message:---------------------------------
function encode()
    i = 1   #counter for encoding progress
    for h in 1:n
        for w in 1:m    #loop through pixels
            lsb = UInt8(imgE[h, w]%2);  #lsb of each pixel
            if i <= mlen                #still encoding
                if msgE[i]==1 & lsb==0
                    imgE[h, w] += 1;
                elseif msgE[i]==1 & lsb==0
                    imgE[h, w] -= 1;
                else
                    continue            #pixel lsb and msgE[1] equal
                end
            else                        #Past msg length, clear lsb
                if lsb==1
                    imgE[h, w] -= 1;
                end
            end
            i += 1
        end
    end
end

encode()

#-----------------------Save Encoded Image:----------------------------
save("YODA_image_encoded.jpg", imgE)

#----------------------Decode Message:---------------------------------
msgD = BitVector()
message2 = Vector{UInt8}()

function decode()
    for h in 1:n
        for w in 1:m    #loop through pixels
            lsb = UInt8(imgE[h, w]%2);  #lsb of each pixel
            append!(msgD, lsb)          #add lsb to decoded message
        end
    end
    for i in 1:(mlen/8)
        println(i)
    end
end



decode()
