pragma solidity ^0.8.13;

import { Xml } from './Xml.sol';

library Html {
  function html(string memory children) internal pure returns (string memory) {
    return Xml.elWithoutProps('html', children);
  }

  function head(string memory children) internal pure returns (string memory) {
    return Xml.elWithoutProps('head', children);
  }

  function title(string memory children) internal pure returns (string memory) {
    return Xml.elWithoutProps('title', children);
  }

  function style(string memory css) internal pure returns (string memory) {
    return Xml.elWithoutProps('style', css);
  }

  function body(string memory children) internal pure returns (string memory) {
    return Xml.elWithoutProps('body', children);
  }
}
