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
mlen = size(message)[1]*8

#-------------------------Retrieve Image Data:---------------------------
img = load("YODA_image_original.jpg")
img = rawview(channelview(Gray.(img)))
n, m = size(img);
println(summary(img))
println("m: ", m, " n: ", n)

#------------------------Encode Message:---------------------------------
function encode()
    i = 1   #counter for encoding progress
    for h in 1:n
        for w in 1:m
            if i <= mlen
                nbyte = UInt8(ceil(i/8))
                if i%8 == 0
                    nbit = 8
                else
                    nbit = UInt8(i%8)
                end
                img[h, w][8] = message[nbyte][nbit]
            else
                img[h, w][8] = 0
            end
            i += 1
        end
    end
end

encode()

#-----------------------Save Encoded Image:----------------------------
save("YODA_image_encoded.jpg", img)

#----------------------Decode Message:---------------------------------
