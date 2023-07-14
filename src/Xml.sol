pragma solidity ^0.8.13;

library Xml {
  // A generic element, can be used to construct any SVG (or HTML) element
  function el(string memory tag, string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return string.concat('<', tag, ' ', props, '>', children, '</', tag, '>');
  }

  // A generic element, can be used to construct any SVG (or HTML) element without children
  function el(string memory tag, string memory props) internal pure returns (string memory) {
    return string.concat('<', tag, ' ', props, '/>');
  }

  function elWithoutProps(string memory tag, string memory children) internal pure returns (string memory) {
    return string.concat('<', tag, '>', children, '</', tag, '>');
  }

  // An SVG attribute
  function prop(string memory key, string memory val) internal pure returns (string memory) {
    return string.concat(key, '=', '"', val, '" ');
  }
}
