// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


import {Hooks} from "@uniswap/v4-core/contracts/libraries/Hooks.sol";
import {IPoolManager} from "@uniswap/v4-core/contracts/interfaces/IPoolManager.sol";
import {BalanceDelta} from "@uniswap/v4-core/contracts/types/BalanceDelta.sol";


contract Router {
  error NotPoolManager();
  error NotSelf();
  error InvalidPool();
  error LockFailure();
  error HookNotImplemented();

  /// @notice The address of the pool manager
  IPoolManager public immutable poolManager;

  /// @dev Only the pool manager may call this function
  modifier poolManagerOnly() {
    if (msg.sender != address(poolManager)) revert NotPoolManager();
    _;
  }


  constructor(IPoolManager _poolManager) {
    poolManager = _poolManager;
  }
  

  function getHooksCalls() public pure returns (Hooks.Calls memory) {
    return Hooks.Calls({
      beforeInitialize: true,
      afterInitialize: true,
      beforeModifyPosition: true,
      afterModifyPosition: true,
      beforeSwap: true,
      afterSwap: true,
      beforeDonate: true,
      afterDonate: true
    });
  }

  
  

  function beforeInitialize(address, IPoolManager.PoolKey calldata, uint160) external virtual returns (bytes4) {
    return Router.beforeInitialize.selector;
  }

  function afterInitialize(address, IPoolManager.PoolKey calldata, uint160, int24)
    external
    virtual
    returns (bytes4)
  {
    return Router.afterInitialize.selector;
  }

  function beforeModifyPosition(address, IPoolManager.PoolKey calldata, IPoolManager.ModifyPositionParams calldata)
    external
    virtual
    returns (bytes4)
  {
    return Router.beforeModifyPosition.selector;
  }

  function afterModifyPosition(
    address,
    IPoolManager.PoolKey calldata,
    IPoolManager.ModifyPositionParams calldata,
    BalanceDelta
  ) external virtual returns (bytes4) {
    return Router.afterModifyPosition.selector;
  }

  function beforeSwap(address, IPoolManager.PoolKey calldata, IPoolManager.SwapParams calldata)
    external
    virtual
    returns (bytes4)
  {
    return Router.beforeSwap.selector;
  }

  function afterSwap(address, IPoolManager.PoolKey calldata, IPoolManager.SwapParams calldata, BalanceDelta)
    external
    virtual
    returns (bytes4)
  {
    return Router.afterSwap.selector;
  }

  function beforeDonate(address, IPoolManager.PoolKey calldata, uint256, uint256) external virtual returns (bytes4) {
    return Router.beforeDonate.selector;
  }

  function afterDonate(address, IPoolManager.PoolKey calldata, uint256, uint256) external virtual returns (bytes4) {
    return Router.afterDonate.selector;
  }

}