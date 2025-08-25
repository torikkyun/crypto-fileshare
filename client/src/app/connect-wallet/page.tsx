'use client';

import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import Image from 'next/image';
import { Lock } from 'lucide-react';
import { useConnect } from 'wagmi';
import { injected } from 'wagmi/connectors';

export default function ConnectWallet() {
  const { connect, isPending } = useConnect();

  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <Card className="w-full max-w-md">
        <CardHeader className="flex flex-col items-center gap-2">
          <Lock size={40} className="text-black dark:text-white" />
          <CardTitle className="text-2xl font-bold tracking-tight text-center">
            Crypto File Share
          </CardTitle>
          <p className="text-muted-foreground text-center text-base">
            Your files, <span className="font-semibold">encrypted</span>.<br />
            Your data, <span className="font-semibold">on chain</span>.
          </p>
        </CardHeader>
        <CardContent className="flex flex-col gap-4 mt-2">
          <Button
            variant="outline"
            size="lg"
            className="flex items-center gap-2 justify-center font-semibold"
            onClick={() => connect({ connector: injected() })}
            disabled={isPending}
          >
            <Image src="/metamask.svg" alt="MetaMask" width={20} height={20} />
            {isPending ? 'Đang kết nối...' : 'Kết nối với MetaMask'}
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
