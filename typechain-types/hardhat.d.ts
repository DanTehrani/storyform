/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { ethers } from "ethers";
import {
  FactoryOptions,
  HardhatEthersHelpers as HardhatEthersHelpersBase,
} from "@nomiclabs/hardhat-ethers/types";

import * as Contracts from ".";

declare module "hardhat/types/runtime" {
  interface HardhatEthersHelpers extends HardhatEthersHelpersBase {
    getContractFactory(
      name: "SemaphoreCore",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.SemaphoreCore__factory>;
    getContractFactory(
      name: "SemaphoreGroups",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.SemaphoreGroups__factory>;
    getContractFactory(
      name: "ISemaphoreCore",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ISemaphoreCore__factory>;
    getContractFactory(
      name: "ISemaphoreGroups",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ISemaphoreGroups__factory>;
    getContractFactory(
      name: "IVerifier",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IVerifier__factory>;
    getContractFactory(
      name: "PoseidonT3",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.PoseidonT3__factory>;
    getContractFactory(
      name: "PoseidonT6",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.PoseidonT6__factory>;
    getContractFactory(
      name: "IStoryFormVerifier",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IStoryFormVerifier__factory>;
    getContractFactory(
      name: "StoryForm",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.StoryForm__factory>;
    getContractFactory(
      name: "Pairing",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Pairing__factory>;
    getContractFactory(
      name: "SemaphoreVerifier16",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.SemaphoreVerifier16__factory>;
    getContractFactory(
      name: "Verifier",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Verifier__factory>;

    getContractAt(
      name: "SemaphoreCore",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.SemaphoreCore>;
    getContractAt(
      name: "SemaphoreGroups",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.SemaphoreGroups>;
    getContractAt(
      name: "ISemaphoreCore",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ISemaphoreCore>;
    getContractAt(
      name: "ISemaphoreGroups",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.ISemaphoreGroups>;
    getContractAt(
      name: "IVerifier",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IVerifier>;
    getContractAt(
      name: "PoseidonT3",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.PoseidonT3>;
    getContractAt(
      name: "PoseidonT6",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.PoseidonT6>;
    getContractAt(
      name: "IStoryFormVerifier",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.IStoryFormVerifier>;
    getContractAt(
      name: "StoryForm",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.StoryForm>;
    getContractAt(
      name: "Pairing",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Pairing>;
    getContractAt(
      name: "SemaphoreVerifier16",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.SemaphoreVerifier16>;
    getContractAt(
      name: "Verifier",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Verifier>;

    // default types
    getContractFactory(
      name: string,
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<ethers.ContractFactory>;
    getContractFactory(
      abi: any[],
      bytecode: ethers.utils.BytesLike,
      signer?: ethers.Signer
    ): Promise<ethers.ContractFactory>;
    getContractAt(
      nameOrAbi: string | any[],
      address: string,
      signer?: ethers.Signer
    ): Promise<ethers.Contract>;
  }
}
