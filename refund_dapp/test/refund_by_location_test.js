const paybylocation = artifacts.require("paybylocation");


contract("paybylocation", function () {
  it("Deployment should assert true", async function () {
    await paybylocation.deployed();
    return assert.isTrue(true);
  });
  it("should assert true", async function () {
    var con = await paybylocation.deployed();
    return assert.isTrue(await con.sqrt(36)==6);
  });
  it("should assert true", async function () {
    var con = await paybylocation.deployed();
    return assert.isTrue(await con.distance_calculator(3,7,9,15)==10);
  });
});