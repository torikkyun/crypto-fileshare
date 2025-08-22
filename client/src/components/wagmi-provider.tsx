'use client';

import { WagmiProvider } from 'wagmi';
import { config } from '@/lib/wagmi-config';

export default function Wagmi({ children }: { children: React.ReactNode }) {
  return <WagmiProvider config={config}>{children}</WagmiProvider>;
}
