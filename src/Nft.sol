pragma solidity ^0.8.13;

import { ERC721 } from 'solmate/tokens/ERC721.sol';
import { LibString } from 'solmate/utils/LibString.sol';
import { Owned } from 'solmate/auth/Owned.sol';
import { Json } from './Json.sol';
import { Metadata } from './Metadata.sol';
import { Renderer } from './Renderer.sol';

contract Nft is Owned, ERC721, Renderer {
  error MintIncorrectPrice();

  uint256 public mintPrice;
  uint256 public totalSupply;

  constructor(uint256 price) Owned(msg.sender) ERC721('Onchain SVG Template', 'OST') {
    mintPrice = price;
  }

  function mint() external payable {
    if (msg.value != mintPrice) {
      revert MintIncorrectPrice();
    }

    _safeMint(msg.sender, ++totalSupply);
  }

  function withdraw() external onlyOwner {
    payable(msg.sender).transfer(address(this).balance);
  }

  // https://docs.opensea.io/docs/contract-level-metadata
  function contractURI() external view returns (string memory) {
    return Metadata.encodeJson(
      Json.json(
        string.concat(
          Json.entry('name', Json.quote(name)),
          ',',
          Json.entry('description', Json.quote('Collection description')),
          ',',
          Json.entry('image', Json.quote(Metadata.encodeSvg(Renderer.renderCollectionImage()))),
          ',',
          Json.entry(
            'external_link', Json.quote('https://github.com/alex-grover/onchain-svg-template')
          )
        )
      )
    );
  }

  // https://docs.opensea.io/docs/metadata-standards
  function tokenURI(uint256 id) public view override returns (string memory) {
    return Metadata.encodeJson(
      Json.json(
        string.concat(
          Json.entry('name', Json.quote(string.concat(name, ' #', LibString.toString(id)))),
          ',',
          Json.entry('description', Json.quote('Token description')),
          ',',
          Json.entry('image', Json.quote(Metadata.encodeSvg(Renderer.renderImage(id)))),
          ',',
          Json.entry('animation_url', Json.quote(Metadata.encodeHtml(Renderer.renderAnimation(id))))
        )
      )
    );
    // external_url
    // background_color
    // attributes
  }
}
