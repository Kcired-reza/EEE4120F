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
textmessage = "START\nThe turkey has left the oven, I repeat, THE TURKEY HAS LEFT THE OVEN!\nFINISH"
message = Vector{UInt8}(textmessage) #array of ascii values
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
mlen = size(msgE)[1] #Length of secret message in bits
n, m = size(imgG); #Dimensions of Image
lsb = 0;    #Idk why this has to be here

for h = 1:n
    for w = 1:m    #loop through pixels
        global lsb = UInt8(imgG[h, w]%2);  #lsb of each pixel
        #println(lsb)
        #println(msg[i])
        if i <= mlen                #still encoding
            if (msgE[i]==1) & (lsb==0)
                #println("INCREMENTED")
                global imgG[h, w] += 1;
            end
            if (msgE[i]==0) & (lsb==1)
                #println("DECREMENTED")
                global imgG[h, w] -= 1;
            end
        else                        #Past msg length, clear lsb
            if lsb==1
                #println("bit cleared")
                global imgG[h, w] -= 1;
            else
                #println("ignored")
            end
        end
        global i += 1
    end
end

#-----------------------Save Encoded Image:----------------------------
save("YODA_zebra_encoded.jpg", imgG)

#----------------------Decode Message:---------------------------------
msgD = Vector{UInt8}(); #Array of bits of the ascii values

#retrieve data from message
for h = 1:n
    for w = 1:m    #loop through pixels
        global lsb = UInt8(imgG[h, w]%2);  #lsb of each pixel
        append!(msgD, lsb);          #add lsb to decoded message
    end
end

#convert data to text
message2 = Vector{UInt8}(); #ASCII Values of the message
mlen2 = UInt16(size(msgD)[1]/8)
byteval = 0;
power = 0;
stopcode = Vector{UInt8}("FINISH");

for j = 1:mlen2 #loop for each byte in message2
    global byteval = UInt8(0);
    for k = 1:8    #loop for each bit in each byte
        global lsb = msgD[8*(j-1) + k]
        global power = 2^(8-k)
        global byteval += lsb*power
    end
    append!(message2, byteval);
    if (j>6)
        if (message2[j-5:j]) == stopcode
            break;
        end
    end
end
msgFinal = String(message2);
println(msgFinal)
