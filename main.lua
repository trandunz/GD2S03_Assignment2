
pileModule = require("pile")

os.execute("cls")
score = 7
io.write("Starting Stack Size: ")
io.flush()
score = tonumber(io.read())
while score < tonumber(3) do
    os.execute("cls")
    print("Please Enter A Stack Size of 3 or more!");
    io.write("Starting Stack Size: ")
    io.flush()
    score = tonumber(io.read())
end

pileModule.AddPile(tonumber(score))
print(pileModule.piles[0])
