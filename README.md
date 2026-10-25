# piplineskills

我的 Claude Code 全域 skill：用「停點流水線」方法新建與擴充專案。

| 指令 | 用途 |
|---|---|
| `/new-pipeline <主題>` | 新建一條停點流水線：空資料夾，或還沒有流水線的既有專案 |
| `/extend-pipeline <功能>` | 在已經建好的流水線上加功能或改階段 |

`extend-pipeline` 會讀 `new-pipeline` 的共用規則，兩個都要裝。

## 安裝

```bash
git clone https://github.com/sleepersusu/piplineskills.git
cd piplineskills
./install.sh
```

`install.sh` 會把 `skills/` 底下的 skill 複製到 `~/.claude/skills/`；本機已有不同版本時會先備份到 `~/.claude/skills-backup/<名稱>-<時間>`（放在 skills 資料夾外，才不會被當成重複的 skill 載入）。

接著在 Claude Code 輸入框一行一行打（安裝 grilling、domain-modeling、skill-creator 等依賴）：

```
/plugin marketplace add mattpocock/skills
/plugin install mattpocock-skills@mattpocock
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
/plugin install example-skills@anthropic-agent-skills
```

重開 Claude Code，用 `/skills` 確認。

## 更新

```bash
cd piplineskills
git pull
./install.sh
```

## 改了 skill 之後上傳

在 `~/.claude/skills/` 改完後，複製回這個 repo 再 push：

```bash
cp -R ~/.claude/skills/new-pipeline ~/.claude/skills/extend-pipeline skills/
git add -A && git commit -m "更新 skill" && git push
```
