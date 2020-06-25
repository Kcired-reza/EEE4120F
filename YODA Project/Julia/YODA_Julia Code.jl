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
imgO = load("YODA_zebra_original.jpg")
imgG = rawview(channelview(Gray.(imgO)))
save("YODA_zebra_grey.jpg", imgG)

#------------------------Encode Message:---------------------------------
i = 1; #counter for encoding
function encode(imgArr, msg)
    mlen = size(msg)[1] #Length of secret message in bits
    n, m = size(imgArr); #Dimensions of Image

    for h in 1:n
        for w in 1:m    #loop through pixels
            lsb = UInt8(imgArr[h, w]%2);  #lsb of each pixel
            #println(lsb)
            #println(msg[i])
            if i <= mlen                #still encoding
                if msg[i]==1 & lsb==0
                    println("INCREMENTED")
                    imgArr[h, w] += 1;
                elseif msg[i]==0 & lsb==1
                    println("DECREMENTED")
                    imgArr[h, w] -= 1;
                else
                    #println("continued...")
                    continue            #pixel lsb and msgE[1] equal
                end
            else                        #Past msg length, clear lsb
                if lsb==1
                    println("bit cleared")
                    imgArr[h, w] -= 1;
                else
                    println("ignored")
                end
            end
            global i += 1
        end
    end
    return imgArr
end

imgE = encode(imgG, msgE);

#-----------------------Save Encoded Image:----------------------------
save("YODA_zebra_encoded.jpg", imgE)

#----------------------Decode Message:---------------------------------
function decode(imgArr)
    n, m = size(imgArr); #Dimensions of Image
    msg = Vector{UInt8}(); #Array of bits of the ascii values

    #retrieve data from message
    for h in 1:n
        for w in 1:m    #loop through pixels
            lsb = UInt8(imgArr[h, w]%2);  #lsb of each pixel
            append!(msg, lsb);          #add lsb to decoded message
        end
    end
    return msg
end

msgD = decode(imgE) #Bits of ASCII Values

#convert data to text
function bitstotext(msg)
    mlen = size(msg)[1] #Length of secret message in bits
    message = Vector{UInt8}(); #ASCII Values of the message
    for i in UInt(1):UInt(mlen/8) #loop for each byte in message2
        append!(message, UInt8(0));
        for j in 1:8    #loop for each bit in each byte
            message[i] += (msg[8*(i-1) + j] << (8 - j));
        end
    end
    return message
end

message2 = bitstotext(msgD);
msgFinal = String(message2);
#println(msgFinal);
