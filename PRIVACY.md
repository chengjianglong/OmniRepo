# OmniRepo Privacy Policy

_Last updated: November 19, 2026_

OmniRepo helps you read and understand code repositories, models, and datasets. This policy explains what happens to your information when you use the OmniRepo apps for Mac, iPhone, and iPad.

## The short version

- OmniRepo has no account system, no analytics, no advertising, and no tracking.
- The developer does not collect, receive, or store any of your data.
- Repositories you open, the reports and answers OmniRepo generates, and your settings stay on your devices.
- Repository excerpts leave your device only when you choose a cloud model, and only after you agree for that repository.

## What OmniRepo stores on your device

- Copies of the repositories you download (in the app's caches folder; you can delete them in Settings).
- Saved reports and Ask Me Anything conversations, per repository (in the app's Application Support folder; you can delete them in Settings).
- Your preferences, such as selected models, prompts, and display settings.
- API keys and the Mac pairing code, in the system Keychain.

## Network requests OmniRepo makes for you

OmniRepo connects to these services only to do what you ask:

| Service | When | What is sent |
| --- | --- | --- |
| GitHub, Hugging Face, or the Git host you enter | Downloading or browsing a repository, model, dataset, or account; showing Discover | The repository or account name you entered and standard request information. Discover loads owner avatars from github.com. |
| Anthropic (Claude) or OpenAI (ChatGPT/GPT) | Only when you select one of their models and agree to send excerpts for the repository | Your question and excerpts of the repository (up to about 60,000 characters), sent with your own API key or through your own signed-in `claude` or `codex` tool on your Mac. Their own privacy policies apply. |
| Ollama | When you use a local model | Your question and repository excerpts, sent to the Ollama server you configure (by default on your own Mac). |
| Your paired Mac | When your iPhone or iPad uses models on your Mac | Your question and repository excerpts, sent over your local network to the OmniRepo app on your Mac. |
| Hugging Face | When you download the optional on-device model on iPhone or iPad | A standard download request for the model files. |
| Web pages you open | When you tap a link in a README, report, or answer | A normal web request to that site, shown in OmniRepo's built-in browser. |

On-device models (Ollama on your Mac, or Qwen on your iPhone or iPad) keep repository content on your devices.

## Subscriptions

OmniRepo Pro is sold through Apple's App Store. Apple processes payments; the developer never receives your payment details. OmniRepo checks your subscription with Apple's StoreKit on your device.

## Children

OmniRepo is not directed at children under 13 and does not knowingly collect information from anyone.

## Changes

If this policy changes, the updated version will be posted here with a new date.

## Contact

Questions about this policy: open an issue at https://github.com/chengjianglong/OmniRepo/issues.
