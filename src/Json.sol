pragma solidity ^0.8.13;

library Json {
  function json(string memory entries) internal pure returns (string memory) {
    return string.concat('{', entries, '}');
  }

  function entry(string memory key, string memory value) internal pure returns (string memory) {
    return string.concat(quote(key), ':', value);
  }

  function quote(string memory value) internal pure returns (string memory) {
    return string.concat('"', value, '"');
  }
}
