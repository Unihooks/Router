// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


import {IPoolManager} from "@uniswap/v4-core/contracts/interfaces/IPoolManager.sol";
import {BalanceDelta} from "@uniswap/v4-core/contracts/types/BalanceDelta.sol";


contract Router {
  error NotPoolManager();
  error NotSelf();
  error InvalidPool();
  error LockFailure();
  error HookNotImplemented();
  

  function beforeInitialize(address, IPoolManager.PoolKey calldata, uint160) external virtual returns (bytes4) {
    revert HookNotImplemented();
  }

  function afterInitialize(address, IPoolManager.PoolKey calldata, uint160, int24)
    external
    virtual
    returns (bytes4)
  {
    revert HookNotImplemented();
  }

  function beforeModifyPosition(address, IPoolManager.PoolKey calldata, IPoolManager.ModifyPositionParams calldata)
    external
    virtual
    returns (bytes4)
  {
    revert HookNotImplemented();
  }

  function afterModifyPosition(
    address,
    IPoolManager.PoolKey calldata,
    IPoolManager.ModifyPositionParams calldata,
    BalanceDelta
  ) external virtual returns (bytes4) {
    revert HookNotImplemented();
  }

  function beforeSwap(address, IPoolManager.PoolKey calldata, IPoolManager.SwapParams calldata)
    external
    virtual
    returns (bytes4)
  {
    revert HookNotImplemented();
  }

  function afterSwap(address, IPoolManager.PoolKey calldata, IPoolManager.SwapParams calldata, BalanceDelta)
    external
    virtual
    returns (bytes4)
  {
    revert HookNotImplemented();
  }

  function beforeDonate(address, IPoolManager.PoolKey calldata, uint256, uint256) external virtual returns (bytes4) {
    revert HookNotImplemented();
  }

  function afterDonate(address, IPoolManager.PoolKey calldata, uint256, uint256) external virtual returns (bytes4) {
    revert HookNotImplemented();
  }

}