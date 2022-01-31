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

            var acc = await window.App.web3.eth.getAccounts();
            var userRole = await window.App.main.methods.getRoleOf().call({from: acc[0]});

            if (userRole == 'payer') {
                $('.withdraw').show();
                $('.fund').show();
            } else {
                $('.withdraw').hide();
                $('.fund').hide();
            }

            if (userRole == 'manager') {
                $("#create-task").show();
            } else {
                $("#create-task").hide();
            }


            if (userRole == 'freelancer') {
                $('.solve').show();
            } else {
                $('.solve').hide();
            }


            setInterval(async function() {
                var mtpAmount =  await window.App.main.methods.getBalanceOf().call({from: acc[0]});
                var userRole = await window.App.main.methods.getRoleOf().call({from: acc[0]});
                $("#account-manager").html(
                    "<b> Account: " + userRole + '<p/>' +
                    "<p> MetaPoints: " + mtpAmount + "</p>"
                );
            }, 3000);

            console.log("[Main contract] connect success");
        } catch(error) {
            console.log("Could not connect with main contract on chain [Main]! ");
        }
    },

    createTask: async function(name, description, domainOfExpertise, evalFee, freelancerFee) {
        var acc = await window.App.web3.eth.getAccounts();
        this.main.methods.createTask().call({from: acc[0]});
    }

};

window.App = App;

$("#create-task").on('click', async function() {
    // fetch data about task parameters
    // also add bootstrap magic

    var acc = await window.App.web3.eth.getAccounts();

    var userRole = await window.App.main.methods.getRoleOf().call({from: acc[0]});
    console.log(userRole);

    if (userRole == "manager") {
        // window.App.createTask();
        console.log("creeating task");
        $("#createTask").modal();
    } else {
        console.log("only managers can create tasks")
    }
});


$("#submit-task").on('click', async function() {

//     function createTask(string memory name,
//         string memory description,
//         string memory domainOfExpertise,
//         uint256 evalFee,
//         uint256 freelancerFee
// ) public {
    var name = $("#taskName").val();
    var domainOfExpertise = $("#domainOfExpertise").val();
    var description = $("#description").val();
    var evalFee = parseInt($("#evalFee").val());
    var freelancerFee = parseInt($("#freelancerFee").val());

    console.log(name);
    console.log(domainOfExpertise);
    console.log(description);
    console.log(evalFee);
    console.log(freelancerFee);


    await window.App.main.methods.createTask(name, domainOfExpertise, description, evalFee, freelancerFee).call();
    
    var tasks = JSON.parse(window.localStorage.getItem("tasks")) || [];
    tasks.push({
        name: name,
        domainOfExpertise: domainOfExpertise,
        description: description,
        evalFee: evalFee,
        freelancerFee: freelancerFee
    });
    window.localStorage.setItem("tasks", JSON.stringify(tasks));

});



window.addEventListener("load", function() {

    $(function(){
        $('#grid').gridstrap({});
    });

    loadTasks();

    if (window.ethereum) {
        // use MetaMask's provider
        App.web3 = new Web3(window.ethereum);
        window.ethereum.enable(); // get permission to access accounts
        console.log('Ethereum branch 1');
    } else {
        console.warn("No web3 detected. Falling back to http://127.0.0.1:8545. You should remove this fallback when you deploy live",);
        // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
        App.web3 = new Web3(
            new Web3.providers.HttpProvider("http://127.0.0.1:8545"),
        );
    }

    App.start();
});


function loadTasks() {

    $("#grid").html("");

    var tasks = JSON.parse(window.localStorage.getItem("tasks")) || [];

    for (var i = 0; i < tasks.length; i++) {
        var task = tasks[i];

        $("#grid").append(makeCell(task.name, task.domainOfExpertise, task.description, task.evalFee, task.freelancerFee));
    }

}

function makeCell(name, domainOfExpertise, description, evalFee, freelancerFee) {
    return '<div class="col-xs-12 col-sm-6 col-md-3" style="border: 2px solid black;">' +
                'TaskName: ' + name + '<br/>' +
                'Domain of expertise: ' + domainOfExpertise + '<div/>' +
                'Description: ' + description + '<br/>' +
                'Eval fee: ' + evalFee + '<br/>' +
                'Freelancer fee' + freelancerFee + '<br/>' +
                '<button class="fund btn btn-primary"> Fund </button>' + 
                '<button class="withdraw btn btn-primary"> Withdraw </button>' +
                '<button class="solve btn btn-primary"> Apply </button>' +
        "</div>";
}