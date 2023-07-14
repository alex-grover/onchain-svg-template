pragma solidity ^0.8.13;

import { LibString } from 'solmate/utils/LibString.sol';
import { Xml } from './Xml.sol';

// Core SVG utility library which helps us construct onchain SVGs with a simple, web-like API.
library Svg {
  /* Main elements */

  function svg(string memory props, string memory children) internal pure returns (string memory) {
    return Xml.el('svg', props, children);
  }

  function g(string memory props, string memory children) internal pure returns (string memory) {
    return Xml.el('g', props, children);
  }

  function path(string memory props, string memory children) internal pure returns (string memory) {
    return Xml.el('path', props, children);
  }

  function text(string memory props, string memory children) internal pure returns (string memory) {
    return Xml.el('text', props, children);
  }

  function line(string memory props, string memory children) internal pure returns (string memory) {
    return Xml.el('line', props, children);
  }

  function circle(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return Xml.el('circle', props, children);
  }

  function circle(string memory props) internal pure returns (string memory) {
    return Xml.el('circle', props);
  }

  function rect(string memory props, string memory children) internal pure returns (string memory) {
    return Xml.el('rect', props, children);
  }

  function rect(string memory props) internal pure returns (string memory) {
    return Xml.el('rect', props);
  }

  function filter(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return Xml.el('filter', props, children);
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
    return Xml.el('radialGradient', props, children);
  }

  function linearGradient(string memory props, string memory children)
    internal
    pure
    returns (string memory)
  {
    return Xml.el('linearGradient', props, children);
  }

  function gradientStop(uint256 offset, string memory stopColor, string memory props)
    internal
    pure
    returns (string memory)
  {
    return Xml.el(
      'stop',
      string.concat(
        Xml.prop('stop-color', stopColor),
        ' ',
        Xml.prop('offset', string.concat(LibString.toString(offset), '%')),
        ' ',
        props
      )
    );
  }

  function animateTransform(string memory props) internal pure returns (string memory) {
    return Xml.el('animateTransform', props);
  }

  function image(string memory href, string memory props) internal pure returns (string memory) {
    return Xml.el('image', string.concat(Xml.prop('href', href), ' ', props));
  }

  /* Re-exported XML utilities */

  // An SVG attribute
  function prop(string memory key, string memory val) internal pure returns (string memory) {
    return Xml.prop(key, val);
  }
}
