pragma solidity ^0.8.13;

import { Test } from 'forge-std/Test.sol';
import { Nft } from '../src/Nft.sol';

contract NftTest is Test {
  address private owner;
  Nft private nft;

  function setUp() public {
    owner = makeAddr('owner');
    vm.prank(owner);
    nft = new Nft(0);
  }

  // TODO: test mint

  function testWithdraw() public {
    vm.prank(owner);
    nft.withdraw();
  }

  function testWithdrawErrorsIfNotOwner() public {
    vm.expectRevert();
    nft.withdraw();
  }
}
