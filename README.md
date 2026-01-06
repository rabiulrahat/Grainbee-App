<div align="center">

# 🌾 Grainbee App (Frontend)

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Backend](https://img.shields.io/badge/Backend-Grainbee_Blockchain-2E7D32?style=for-the-badge&logo=hyperledger)](https://github.com/JonyBepary/Grainbee_Blockchain)

**Grainbee** is a Flutter-based mobile client for a **blockchain-powered TCB ration distribution system**, built to work with the Hyperledger Fabric backend in `JonyBepary/Grainbee_Blockchain`.[web:81][web:190]

</div>

---

## 🎯 Project Goal: Fixing the BD TCB Ration System

The goal of Grainbee is to make the **Trading Corporation of Bangladesh (TCB) ration system** transparent, fair, and auditable.

- 🧩 **Problem**  
  Manual ration distribution suffers from data errors, middlemen, fake entries, and poor tracking.  
- 🧍‍♂️ **Impact**  
  Many low‑income families do not receive their full entitled ration benefits.  
- 🚀 **Vision**  
  Use a **blockchain‑backed digital platform** so every ration transaction is traceable, tamper‑evident, and visible to authorities in near real time.

This repository is the **frontend app** that officers, dealers, or citizens use; all trusted data and business logic live in the **Grainbee_Blockchain** backend.

---

## 🔗 Backend Connection

- **Backend repo**: [`JonyBepary/Grainbee_Blockchain`](https://github.com/JonyBepary/Grainbee_Blockchain)  
- **Technology**: Hyperledger Fabric–based blockchain for ration records, member registries, and distribution events.
- The app communicates with REST/gRPC APIs exposed by the Fabric network (gateway service), so:
  - Every issued ration card,
  - Every pickup,
  - Every allocation/update  
  is recorded on an immutable ledger.

---

## ✨ Key Features (Frontend)

Aligned directly with the TCB problem:

- 🧾 **Verified Member Registration & Ration Card Generation**
  - Capture household info, NID, eligibility, and attach them to a blockchain‑backed member record.
  - Generate a **digital ration card** (ID/QR) mapped to that member on-chain.

- ⏰ **Real‑Time Distribution Schedule & Status**
  - Show current and upcoming TCB distribution slots (date, time, location, quota).
  - View status like “Not started / Ongoing / Completed” for each distribution center.

- ✅ **Tamperproof Ration Records**
  - All distribution events (who picked up what, when, where) are persisted on the Fabric ledger.
  - Prevents double‑dipping, fake entries, and manual alteration of history.

- 🔍 **QR‑Based Pickup Verification**
  - Scan member ration QR code at pickup points.
  - Verify eligibility and remaining quota against live blockchain data.
  - Instantly update distribution records after successful pickup.

- 🏛 **Transparency for Authorities**
  - Provide dashboards or data views (via API) so central TCB / govt authorities can:
    - Audit distribution by location/time.
    - Detect anomalies and fraud patterns.
    - Export data for policy and reporting.

*(Exact screens/endpoints depend on your implementation, but the app is designed around these flows.)*

---

## 🛠 Tech Stack

- **Framework**: Flutter  
- **Language**: Dart  
- **Architecture**: Screen + service + model structure (can be evolved into feature‑based or MVVM)  
- **Networking**: `http` / API client to talk to Grainbee_Blockchain gateway  
- **Backend**: Hyperledger Fabric (via `Grainbee_Blockchain`) for secure, immutable ration data.

---

## 🚀 Getting Started

> Make sure your **Grainbee_Blockchain** backend (Fabric network + API gateway) is running and reachable.

### 1. Clone the frontend

```bash
git clone https://github.com/rabiulrahat/Grainbee-App.git
cd Grainbee-App
