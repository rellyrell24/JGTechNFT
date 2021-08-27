const JgTechOne = artifacts.require("JgTechOne");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("JgTechOne", function ( accounts ) {
  it("should assert true", async function () {
    await JgTechOne.deployed();
    return assert.isTrue(true);
  });

  it("should mint token to user1", async function () {
    let owner = accounts[0];
    let user1 = accounts[1];
    let tokenId = 1;
    let instance = await JgTechOne.deployed();
    let img_hash = "QmVU8x817nmiirY2SFJ2NM5nNhMXCDQYSdosnuKu8APKmf"
    await instance.mintToken(user1, img_hash, {"from": owner});
    let c_hash = await instance.getHash(tokenId, {"from": owner});
    return assert.strictEqual(img_hash, c_hash, "transaction verified");
  })

  it("should not mint same token twice", async function () {
    let owner = accounts[0];
    let user1 = accounts[1];
    let user2 = accounts[2];
    let instance = await JgTechOne.deployed();
    let img_hash = "QmQA8hBZpdQJStDRqUrfoTGUA1HrTXkNDTsFkexaFFVbVn"
    await instance.mintToken(user1, img_hash, {"from": owner});
    try {
      await instance.mintToken(user2, img_hash, {"from": owner});
    } catch (error) {
      return assert.isTrue(true);
    }
  })


});
