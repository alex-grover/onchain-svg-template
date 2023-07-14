pragma solidity ^0.8.13;

import { Base64 } from 'openzeppelin/utils/Base64.sol';

library Metadata {
  function encodeJson(string memory json) internal pure returns (string memory) {
    return string.concat('data:application/json;base64,', Base64.encode(bytes(json)));
  }

  function encodeSvg(string memory svg) internal pure returns (string memory) {
    return string.concat('data:image/svg+xml;base64,', Base64.encode(bytes(svg)));
  }

  function encodeHtml(string memory html) internal pure returns (string memory) {
    return string.concat('data:text/html;base64,', Base64.encode(bytes(html)));
  }
}
