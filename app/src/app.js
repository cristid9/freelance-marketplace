import Web3 from "web3";
import mainContractArtifact from "../../build/contracts/Main.json";

const App = {
    web3: null,
    main: null,

    start: async function() {
        const { web3 } = this;

        try {
            const networkId = await web3.eth.net.getId();
            const deployedNetwork = mainContractArtifact.networks[networkId];
            this.main = new web3.eth.Contract(
                mainContractArtifact.abi,
                deployedNetwork.address,
            );

            console.log("[Main contract] connect success");
        } catch(error) {
            console.log("Could not connect with main contract on chain [Main]! ");
        }
    },

    createTask: async function(name, description, domainOfExpertise, evalFee, freelancerFee) {
        this.main.methods.createTask().call();
    }

};

window.App = App;

$("#create-task").on('click', async function() {
    // fetch data about task parameters
    // also add bootstrap magic
    debugger;
    var userRole = await window.App.main.methods.getRoleOf().call();
    console.log(userRole);

    if (userRole == "manager") {
        // window.App.createTask();
        console.log("creeating task");
        $("#createTask").modal();
    } else {
        console.log("only managers can create tasks")
    }
});

window.addEventListener("load", function() {
    if (window.ethereum) {
        // use MetaMask's provider
        App.web3 = new Web3(window.ethereum);
        window.ethereum.enable(); // get permission to access accounts
    } else {
        console.warn("No web3 detected. Falling back to http://127.0.0.1:8545. You should remove this fallback when you deploy live",);
        // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
        App.web3 = new Web3(
            new Web3.providers.HttpProvider("http://127.0.0.1:8545"),
        );
    }

    App.start();
});

