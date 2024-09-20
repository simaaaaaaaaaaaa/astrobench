window.addEventListener('message', function(event) {
    console.log("Received NUI message:", event.data);
    if (event.data.action === 'open') {
        console.log("Opening Repair Bench NUI");
        document.getElementById('repairBench').style.display = 'block';
    } else if (event.data.action === 'close') {
        console.log("Closing Repair Bench NUI");
        document.getElementById('repairBench').style.display = 'none';
    } else {
        console.log("Unknown action:", event.data.action);
    }
});

function repairVehicle() {
    console.log("Repair Vehicle Button Clicked");
    fetch(`https://astrobench/repairVehicle`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {
        console.log(resp);
    });
}

function applyExtra() {
    const extra = document.getElementById('extraSelect').value;
    console.log("Applying Extra:", extra);
    setExtra(extra);
}

function applyLivery() {
    const livery = document.getElementById('liverySelect').value;
    console.log("Applying Livery:", livery);
    setLivery(livery);
}

function setExtra(extra) {
    console.log("Set Extra Button Clicked");
    fetch(`https://astrobench/setExtra`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({ extra: extra })
    }).then(resp => resp.json()).then(resp => {
        console.log(resp);
    });
}

function setLivery(livery) {
    console.log("Set Livery Button Clicked");
    fetch(`https://astrobench/setLivery`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({ livery: livery })
    }).then(resp => resp.json()).then(resp => {
        console.log(resp);
    });
}

function closeMenu() {
    console.log("Close Button Clicked");
    document.getElementById('repairBench').style.display = 'none';
    fetch(`https://astrobench/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {
        console.log(resp);
    });
}

let currentExtra = 1;
let currentLivery = 1;

function updateDisplay() {
    document.getElementById('extraDisplay').textContent = currentExtra;
    document.getElementById('liveryDisplay').textContent = currentLivery;
}

function prevExtra() {
    if (currentExtra > 1) {
        currentExtra--;
        updateDisplay();
    }
}

function nextExtra() {
    if (currentExtra < 12) {
        currentExtra++;
        updateDisplay();
    }
}

function applyExtra() {
    console.log("Applying Extra:", currentExtra);
    setExtra(currentExtra);
}

function prevLivery() {
    if (currentLivery > 1) {
        currentLivery--;
        updateDisplay();
    }
}

function nextLivery() {
    if (currentLivery < 12) {
        currentLivery++;
        updateDisplay();
    }
}

function applyLivery() {
    console.log("Applying Livery:", currentLivery);
    setLivery(currentLivery);
}
// Initial display update
updateDisplay();