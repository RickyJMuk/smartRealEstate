const Web3 = require("web3");
const { abi, evm } = require("./MyToken.json"); 

const web3 = new Web3("YOUR_INFURA_ENDPOINT"); 

const contractAddress = "0xd9260a069B666A052690c2b70435Cbe4a3439C76";
const realEstateContract = new web3.eth.Contract(abi, contractAddress);

async function mintProperty(owner, buyer) {
    const tx = await realEstateContract.methods.mintProperty(buyer).send({ from: owner, gas: 1000000 });
    console.log("Property minted. Transaction hash:", tx.transactionHash);
}

async function transferProperty(owner, buyer, propertyId) {
    const tx = await realEstateContract.methods.transferProperty(buyer, propertyId).send({ from: owner, gas: 1000000 });
    console.log("Property transferred. Transaction hash:", tx.transactionHash);
}

function submitForm() {
    const ownerAddress = document.getElementById("ownerAddress").value;
    const buyerAddress = document.getElementById("buyerAddress").value;

    // Example usage
    mintProperty(ownerAddress, buyerAddress).then(() => transferProperty(ownerAddress, buyerAddress, 0));
}
