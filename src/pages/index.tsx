// @ts-nocheck

import styles from 'styles/Home.module.scss'
import { ThemeToggleButton, ThemeToggleList } from 'components/Theme'
import { useState } from 'react'
import { useNetwork, useSwitchNetwork, useAccount, useBalance } from 'wagmi'
import ConnectWallet from 'components/Connect/ConnectWallet'
import { ConnectButton } from '@rainbow-me/rainbowkit'
import { useConnectModal, useAccountModal, useChainModal } from '@rainbow-me/rainbowkit'
import { useSignMessage } from 'wagmi'
import Image from 'next/image'

export default function Home() {
  return (
    <div className={styles.container}>
      <Header />
      <Main />
      <Footer />
    </div>
  )
}

function Header() {
  return (
    <header className={styles.header}>
      <div className="flex flex-row items-center space-x-2 pl-5 font-bold">
        <Image src="/airplain.png" alt="Picture of the author" width={32} height={32} />
        <div>Flyrance</div>
      </div>

      <div className="flex items-center">
        <div>
          <div className="flex w-full flex-col items-center">
            <ConnectWallet />
          </div>
        </div>
      </div>
    </header>
  )
}

function Main() {
  const { address, isConnected, connector } = useAccount()
  const [destination, setDestination] = useState('')
  const [date, setDate] = useState('')
  const [airline, setAirline] = useState('')

  const { chain, chains } = useNetwork()
  const { isLoading: isNetworkLoading, pendingChainId, switchNetwork } = useSwitchNetwork()
  const { data: balance, isLoading: isBalanceLoading } = useBalance({
    addressOrName: address,
  })
  const { openConnectModal } = useConnectModal()
  const { openAccountModal } = useAccountModal()
  const { openChainModal } = useChainModal()

  return (
    <main className={styles.main + ' space-y-6'}>
      <div className="rounded-md border p-3">
        <div className="text-center font-bold">Safe travel starts with travel protection</div>
        <div className="pt-2">
          <input
            type="text"
            className="p-1 pl-2"
            placeholder="Country of Destination"
            value={destination}
            onChange={e => {
              setDestination(e.currentTarget.destiation)
            }}
          />
        </div>
        <div className="pt-2">
          <input
            type="text"
            className="p-1 pl-2"
            placeholder="Date"
            value={date}
            onChange={e => {
              setDate(e.currentTarget.date)
            }}
          />
        </div>
        <div className="pt-2">
          <input
            type="text"
            className="p-1 pl-2"
            placeholder="Airline"
            value={airline}
            onChange={e => {
              setAirline(e.currentTarget.airline)
            }}
          />
        </div>
        <div className="pt-2">
          <button className="rounded-md border p-2">Submit</button>
        </div>
      </div>
    </main>
  )
}

function SignMsg() {
  const [msg, setMsg] = useState('Dapp Starter')
  const { data, isError, isLoading, isSuccess, signMessage } = useSignMessage({
    message: msg,
  })
  const signMsg = () => {
    if (msg) {
      signMessage()
    }
  }

  return (
    <>
      <p>
        <input value={msg} onChange={e => setMsg(e.target.value)} className="rounded-lg p-1" />
        <button
          disabled={isLoading}
          onClick={() => signMsg()}
          className="ml-1 rounded-lg bg-blue-500 py-1 px-2 text-white transition-all duration-150 hover:scale-105"
        >
          Sign
        </button>
      </p>
      <p>
        {isSuccess && <span>Signature: {data}</span>}
        {isError && <span>Error signing message</span>}
      </p>
    </>
  )
}

function Footer() {
  return (
    <footer className={styles.footer}>
      <div className="flex items-center">
        <ThemeToggleButton />
      </div>
    </footer>
  )
}
