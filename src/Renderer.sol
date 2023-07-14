pragma solidity ^0.8.13;

import { LibString } from 'solmate/utils/LibString.sol';
import { Html } from './Html.sol';
import { Metadata } from './Metadata.sol';
import { Svg } from './Svg.sol';

contract Renderer {
  function renderCollectionImage() public pure returns (string memory) {
    return Svg.svg(
      svgProps(),
      Svg.rect(
        string.concat(
          Svg.prop('width', '100%'), Svg.prop('height', '100%'), Svg.prop('fill', 'black')
        )
      )
    );
  }

  function renderImage(uint256 id) public pure returns (string memory) {
    return Svg.svg(
      svgProps(),
      string.concat(
        Svg.rect(
          string.concat(
            Svg.prop('width', '100%'), Svg.prop('height', '100%'), Svg.prop('fill', '#f7f1e3')
          )
        ),
        Svg.text(
          string.concat(
            Svg.prop('x', '10'),
            Svg.prop('y', '40'),
            Svg.prop('font-size', '10'),
            Svg.prop('fill', '#b33939')
          ),
          string.concat(Svg.cdata('Hello, token #'), LibString.toString(id))
        ),
        Svg.rect(
          string.concat(
            Svg.prop('fill', '#227093'),
            Svg.prop('x', '10'),
            Svg.prop('y', '50'),
            Svg.prop('width', '80'),
            Svg.prop('height', '10')
          ),
          ''
        )
      )
    );
  }

  function renderAnimation(uint256 id) public pure returns (string memory) {
    return Html.html(
      string.concat(
        Html.head(
          string.concat(
            Html.title(string.concat('Onchain SVG #', LibString.toString(id))),
            Html.style('body{margin:0}')
          )
        ),
        Html.body(renderImage(id))
      )
    );
  }

  function svgProps() internal pure returns (string memory) {
    return string.concat(
      Svg.prop('xmlns', 'http://www.w3.org/2000/svg'),
      Svg.prop('width', '100%'),
      Svg.prop('height', '100%'),
      Svg.prop('viewBox', '0 0 100 100')
    );
  }
}
