pragma solidity ^0.8.13;

import { Svg } from './Svg.sol';
import { Utils } from './Utils.sol';

contract Renderer {
  function render(uint256 id) public pure returns (string memory) {
    return Svg.svg(
      string.concat(
        Svg.prop('xmlns', 'http://www.w3.org/2000/svg'),
        Svg.prop('width', '100%'),
        Svg.prop('height', '100%'),
        Svg.prop('viewBox', '0 0 100 100')
      ),
      string.concat(
        Svg.rect(
          string.concat(
            Svg.prop('width', '100%'),
            Svg.prop('height', '100%'),
            Svg.prop('fill', '#f7f1e3')
          )
        ),
        Svg.text(
          string.concat(
            Svg.prop('x', '10'),
            Svg.prop('y', '40'),
            Svg.prop('font-size', '10'),
            Svg.prop('fill', '#b33939')
          ),
          string.concat(Svg.cdata('Hello, token #'), Utils.uint2str(id))
        ),
        Svg.rect(
          string.concat(
            Svg.prop('fill', '#227093'),
            Svg.prop('x', '10'),
            Svg.prop('y', '50'),
            Svg.prop('width', Utils.uint2str(80)),
            Svg.prop('height', Utils.uint2str(10))
          ),
          Utils.NULL
        )
      )
    );
  }
}
