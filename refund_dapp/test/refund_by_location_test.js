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
});