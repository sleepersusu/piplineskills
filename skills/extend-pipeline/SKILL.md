---
name: extend-pipeline
description: 在已經用停點流水線方法建好的專案上加新功能或改階段：先讀現況，只用 grilling 問跟新功能有關的題目，改 docs/design.md 給本人確認後才動 skill，改完重跑回歸實測並跟舊數字比。使用者打 /extend-pipeline、說「幫流水線加功能」「流水線加一段」「改流水線某個階段」時使用。還沒有流水線的專案改用 /new-pipeline。
disable-model-invocation: true
argument-hint: "要加的功能或要改的階段"
---

# extend-pipeline（擴充既有的停點流水線）

回應用繁體中文。共用的做法寫在 `~/.claude/skills/new-pipeline/SKILL.md`：開工前先讀它的「八個模式」「預設架構：兩停點嚴謹模式」「subagent 契約」與步驟 4、5，這裡照那些規則做，不另寫一套。讀不到那個檔 → 停下來，請本人先裝好 `/new-pipeline`。

目前資料夾還沒有 `docs/design.md` 或流水線的 skill → 這不是擴充，停下來請本人改打 `/new-pipeline`。


原則：`docs/design.md` 是正本，先改設計、本人確認，才動 skill；改完一定重跑實測，跟舊數字比。

### E1. 讀現況

- 讀 `CLAUDE.md`、`docs/design.md`、`README.md`、各 skill、`progress.md` 最新的實測數字、`docs/adr/`。
- 有批次還沒跑完（`runs/*/state.json` 不在完成狀態）→ 先問本人：等它跑完再改，還是先改設計、不動正在用的 skill。

### E2. 設計（用 grilling，本人在場）

只問跟新功能有關的題目，一次一題附建議答案；原本 13 題沒受影響的沿用，不重問：

1. 新功能要交出什麼、給誰。
2. 插在哪一段之後，或改哪一段；`stage` 值怎麼變；停點要不要變。
3. 新產出有哪些欄位，各用哪種監督（雙軌／單軌＋出處／機械比對／不驗）。
4. 新的出錯情況，各由哪一層擋住。
5. 驗收判準、判斷規則、例外政策與熔斷、預算、作者界線有沒有要改。
6. 新需要的 skill 與安裝來源。
7. 有沒有新功能的金標準樣本；舊批次要不要補跑新段。

### E3. 改設計稿（停點）

- 改 `docs/design.md`，在最前面寫改了什麼、為什麼；有設計頁就同步更新同一頁。
- 難回頭的決定寫一份 `docs/adr/`。
- 給本人看，**本人確認前不改 CLAUDE.md、skill 或腳本**。

### E4. 實作

- 新 skill 照步驟 4 的寫法與「subagent 契約」做。
- 既有 skill 只改必要的地方：前一段結尾的「接著執行下一個 skill」接上新段，`verify` 的驗收判準與 E2E 檢查加上新段。
- `CLAUDE.md` 的階段表與開工檢查表、`README.md`、規格範本合併更新，不覆蓋。
- 新腳本先寫會失敗的測試。
- 每完成一步 commit 一次。

### E5. 回歸實測

1. 既有測試全過。
2. 金標準與故意埋錯重跑，新段也要埋錯，確認抓得到。
3. 跟 `progress.md` 裡上次的實測數字比，有退步就找出原因修好，或寫進限制。
4. 中斷續跑：從新段中途結束 session，新 session 要能接續。
5. 舊批次的 `state.json` 新版 skill 仍讀得懂；讀不懂就寫轉換方式。
6. 原檔不動：比對雜湊值。

結果寫回 `progress.md`、`docs/design.md` 與設計頁的實測數字表。
