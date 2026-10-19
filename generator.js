import data from "./buildings.json" with { type: "json" };
console.log(data);

class building {
	constructor(type, name) {
		this.left = null;
		this.right = null;
		this.top = null;
		this.bottom = null;

		const objectData = data[type][name];
		this.width = objectData.width;
		this.height = objectData.height;
		this.area = objectData.area;
	}
}

document.getElementById('mybutton').addEventListener('click', show);

function show() {
	document.getElementById('test0').innerHTML = Date();
	const farm = new building("market", "orient");
	document.getElementById('test1').innerHTML = farm.width;
}