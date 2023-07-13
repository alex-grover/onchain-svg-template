pragma solidity ^0.8.13;

import { Utils } from './Utils.sol';

// Core SVG utility library which helps us construct onchain SVGs with a simple, web-like API.
library Svg {
  /* Main elements */

  function svg(string memory props, string memory children) internal pure returns (string memory) {
    return el('svg', props, children);
  }

  function g(string memory props, string memory children) internal pure returns (string memory) {
    return el('g', props, children);
  }

  function path(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('path', props, children);
  }

  function text(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('text', props, children);
  }

  function line(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('line', props, children);
  }

  function circle(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('circle', props, children);
  }

  function circle(string memory props) internal pure returns (string memory) {
    return el('circle', props);
  }

  function rect(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('rect', props, children);
  }

  function rect(string memory props) internal pure returns (string memory) {
    return el('rect', props);
  }

  function filter(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('filter', props, children);
  }

  function cdata(string memory content) internal pure returns (string memory) {
    return string.concat('<![CDATA[', content, ']]>');
  }

  /* Gradients */

  function radialGradient(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('radialGradient', props, children);
  }

  function linearGradient(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return el('linearGradient', props, children);
  }

  function gradientStop(uint256 offset, string memory stopColor, string memory props)
    internal
    pure
    returns (string memory)
  {
    return el(
      'stop',
      string.concat(
        prop('stop-color', stopColor),
        ' ',
        prop('offset', string.concat(Utils.uint2str(offset), '%')),
        ' ',
        props
      )
    );
  }

  function animateTransform(string memory props) internal pure returns (string memory) {
    return el('animateTransform', props);
  }

  function image(string memory href, string memory props) internal pure returns (string memory) {
    return el('image', string.concat(prop('href', href), ' ', props));
  }

  /* Common */

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

  // An SVG attribute
  function prop(string memory key, string memory val) internal pure returns (string memory) {
    return string.concat(key, '=', '"', val, '" ');
  }
}
