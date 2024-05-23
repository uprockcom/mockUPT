NETWORK=mainnet-beta
KEYPAIR_TOKEN_AUTHORITY=./.keypairs/${NETWORK}/TFN8QiEpBFE2hrN8rcADbYrv9oyZiL9TQ66qkasDB4Q.json


TOKEN_MINT=TSTLPnaYJpcjyKaEteb7S13H3XTrCnjZygzuBabuAsV
KEYPAIR_TOKEN_MINT=./.keypairs/${NETWORK}/${TOKEN_MINT}.json

env:
	solana config set --url ${NETWORK}
	solana config set --keypair ${KEYPAIR_TOKEN_AUTHORITY}
	cp ${KEYPAIR_TOKEN_AUTHORITY} ~/.config/solana/id.json

create:
	spl-token create-token --decimals 9 ${KEYPAIR_TOKEN_MINT} || true
	spl-token create-account ${TOKEN_MINT} || true
	spl-token mint ${TOKEN_MINT} 1000000000

metadata-create:
	metaboss create metadata --metadata ./token.json --mint ${TOKEN_MINT}

metadata-update:
	metaboss update uri --account ${TOKEN_MINT} --new-uri=https://raw.githubusercontent.com/uprockcom/mockUPT/main/metadata.json

airdrop:
	solana --url ${NETWORK} \
	--keypair ${KEYPAIR_AUTH} \
	airdrop 1

