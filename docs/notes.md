# Notes

Raw observations, before they become rules. Append freely; distil later.

A note costs ten seconds. It does not have to be right, general, or well
phrased — it has to exist. Insights arrive when work is busiest, and the ones
that survive are otherwise just the ones that happened to arrive on a quiet day.

To distil a note into a rule, it must pass both:

1. does it change what an agent does next?
2. is it general, or this project's instantiation of something general?

Structure and headings in English. **Quotes stay verbatim in whatever language
they were said** — a paraphrase is already an interpretation, and the point of
keeping the original is to be able to re-read it later without my gloss.

---

## 2026-07-30 — retrospective import, July 2026

Recovered from 494 Codex sessions (16,017 user messages, of which 46% were
replayed duplicates, 6% machine-injected, leaving 1,190 real ones). Eight
parallel agents extracted candidates; this is the deduplicated result.

This is a one-time catch-up. The point of this file is that it should never be
needed again.

### A. Already in the skill — but said better here

Replace the current phrasing with these.

**Battering ram — the whole thesis, in the original words**

> 只要不是面相终极目标的直接评估，中间评估永远都有不确定性，你一直在打磨间接
> 尺子，但更直接的方式是直接通过探索和思考和尝试去尝试推进和突破真正终极目标
> 的少数固定验收标准 … 我们的 goal loop 是面向终极目标的"攻城锤"，不是闭门造车
> 花费上万美元纸上谈兵的尺子铺
> — 2026-07-26, five times within one hour

> 你花了近 11 个小时，上万美元，然后一次实质性迭代都没有
> — 2026-07-26T03:30:04

**Why the daytime profile exists**

> 白天尽量多次数的科研主迭代循环，人在环，而且人类在真实数据观察下的直觉和方向
> 感是至关重要的"金子"；另一种是 overnight 无人值守循环，这种就是尽量做完整，
> 做完整结果等人类验收
> — 2026-07-23T08:41:28

Better than the current wording because it says *why* the human is worth
interrupting: their intuition under real data is the scarce resource.

**Why the goal file is immutable**

> goal 文件是禁止你改的，进展应该单独写在一个位置，不然你不是自己又当运动员又
> 当裁判了
> — 2026-07-26T03:01:34

**What "done" is not**

> "配置写好了""任务启动了""训练 loss 很低"或"部分 episode 成功"**均不算完成**
> — 2026-07-18T16:31:44

### B. New, general — candidates for the core

**B1. The two symmetric prohibitions.** The whole framework in one line, and
currently only half of it is stated.

> 不能 为了过验收不择手段 hack ... 不能为了所谓严谨做好几个小时都不做实验，
> 实验数据反馈是极其重要的，本质都是 data-driven
> — 2026-07-15T06:36:31

Both directions are evasions of real data: one fabricates it, the other defers
it. The skill states the second and scatters the first through Floor 2.

**B2. "Why" means why it is worth doing, not why it is possible.** The reporting
order already shipped has this hole.

> 你刚才说了大量为什么，这个看似是在遵从我说的原则，但你的误区是，不是说把你在
> 做的事前面加一个为什么可以做就行了的，你没有理解到真正意图，这里要问的应该是
> 为什么要做这件事，不是说为什么能做这件事
> — 2026-07-29T11:34:40

**B3. An infrastructure failure is not a scientific result.** Floor 1 currently
prevents claiming a run happened when it did not; this is the mirror image —
claiming a mechanism failed when the harness did.

> 这不是 GridPath 地图、Unity player、checkpoint 或 V1 策略的失败，而是 smoke
> wrapper 和父 deploy 脚本之间的 CLI contract mismatch … 不要把这次失败记作
> GridPath behavior failure
> — 2026-07-05T06:41:07

> 只有实际启动并 health-check 过 Unity/player，才允许写 true；argparse 前置失败
> 时应是 false 或 unknown
> — same message

A status field must never claim more than actually happened. A run that died in
argument parsing has not tested the mechanism, and recording it as a behaviour
failure closes a candidate that was never opened.

**B4. A progress report is not a completion.** Repeated at least six times in one
day, with visible frustration.

> 你刚才以 completed 结束，但全套测试、稳定一阶段产物、100-update benchmark …
> 仍未完成 … 不要再用进度报告 completed
> — 2026-07-11T12:02:06, and 12:22, 12:35, 12:47, 13:07, 13:14

**B5. Stop and report on failure. Do not patch and rerun.**

> 如果任何一项失败，停止汇报，不要 patch、不要跑 Unity
> stop / archive partial output / report log tail / do not patch and rerun
> without review
> — 2026-07-05T06:21:26

**B6. Failure leaves evidence. Untracked does not mean disposable.**

> 只要本进程已拥有 output，任何 launch failure（即使容器清理成功）都保留最小
> canonical failure diagnostic … 不得无证据删除 output
> — 2026-07-11T18:59:03

> Do not run git clean. Do not reset or checkout this directory. Do not assume
> untracked means disposable.
> — 2026-07-03T07:16:07

**B7. No silent fallback. Missing critical input is an immediate exit.**

> This silent fallback is unsafe and must be removed for external map mode …
> --map-dir 存在但 --player 缺失时，直接 SystemExit
> — 2026-07-03T07:16:07

> 那要不 port 不给默认值？这样防止忘记给冲突？不给默认值直接报错
> — 2026-07-05T16:55:05

**B8. When a semantic is ambiguous, do not silently pick one — carry all
candidates through the analysis.** Sharp, and not obvious.

> 它没有静默选择窗口对齐，而是要求比较 B1/B2/C1/C2 … 如果 action/state 语义不
> 明确，就把 B1/B2/C1/C2 都带入 M2。这是正确的
> — 2026-07-04T05:50:05

Related, upstream of it:

> 先做 A_action_semantics_audit，确认 action 两个维度的含义、坐标系、raw/
> normalized 状态 … 这个能避免我们把 world-frame action、body-frame action、
> controller command 混在一起
> — same message

**B9. Wording must match the measured error.**

> 如果最终核查发现电压数组并非真正逐 bit 相同，而只是误差接近机器精度 … 不要
> 写 bitwise identical，因为 10^-13 的非零 RMSE 与严格意义上的 bitwise identity
> 不是同一个概念
> — 2026-07-13T13:29:49

> Do not claim cross-build bit identity unless verified. / fail-ready
> placeholders only if files do not yet exist; do not invent hashes.
> — 2026-07-11T01:37:16

**B10. Do not guess a cause. Go back to the script or the result file.**

> 不要猜原因，要从脚本或结果文件中确认
> — 2026-07-13T13:29:49

**B11. One variable per experiment.**

> 为什么这里是 100-step TBPTT，刚才的实验不是同时变了多个变量么 … 那我觉得其实
> 刚才有一个混淆，recurrent 梯度长度和 carry 同时变化了
> — 2026-07-21T11:01:43

> 根本不需要 2x2，一件事就解决了 … 保证控制变量只换 RouteB
> — 2026-07-03T11:53:11

**B12. A threshold the assistant invented is not a contract.**

> 原 1e-5 physical gate 是助手先验，用户实际要求是 bit-exact 为天花板、否则合理
> 误差
> — 2026-07-13T03:08:23

**B13. A hand-tuned constant is a probe, not a prescription.**

> 调 scale 恐怕是密切地图相关的不实用 … scale=3.7 不是药方，是探针 … 它不应该
> 写进正式协议。它没有解释语义，只是调幅度
> — 2026-07-03T18:04:03

**B14. State what was *not* done.**

> explicit statement: no Unity launched / no episodes / no rollout / no training
> / no summary/formal / no Excel / no commit
> — 2026-07-03T07:16:07, repeated 2026-07-04T05:50:05

**B15. Do not agree with me to be agreeable.**

> 你不用迎合我，我只是在说我下意识的一些直觉
> — 2026-07-04T07:08:17

**B16. Expected numbers are declared up front; a mismatch stops the work.**

> 每个 Task 有可复现的期望数字，对不上就停下来说，不要调参去凑
> — 2026-07-25T09:07:20

**B17. Intervene at the mechanism, not the symptom.**

> 我怎么感觉你最近几条不本质呢，只是打补丁？没有从原因和机制分析出发，就像头疼
> 医头，脚痛医脚，不通病理
> — 2026-07-26T17:27:35

**B18. Results before mechanism.**

> 我们必须先拿到这个无可争议的结果证据，再去想假设、看机制。现在不能本末倒置，
> 为了找机制而去做结果
> — 2026-07-14T07:41:54

**B19. No jargon, no invented vocabulary.**

> "同一批代表 episode 并行比较 10/16/10 与历史 8+2" 不要说黑话，这是什么意思？
> — 2026-07-18T15:52:49

> 其实这些代号我听不懂，因为是你自己工作过程中产生的，你能给我直白解释一下
> — 2026-07-26T11:34:58

### C. New — belong in a specific profile

**subagent-driven**

> Excel 负责调度和汇总，但不让并行 agent 直接写同一个 xlsx。每个 row_id 写自己
> 的独立目录、manifest、JSON、log、hash；最后一个 aggregator 单线程重建 Excel
> — 2026-07-04T12:53:50

> 你不是唯一在仓库中工作的代理；不要回退他人修改，适配当前状态。严禁 git add/
> commit/clean，严禁停止、signal 或干扰任何训练/container/watcher，严禁修改
> results 中已封存产物
> — 2026-07-13T01:50:57, and near-verbatim in almost every dispatch

**rapid-prototype**

> 先用小代价的局部预实验/smoke 实验先跑一下 … 这样好处是不用费好几个小时反复想
> 还有什么没有封堵的隐患，而是根据实际小试验情况，直接针对问题做处理
> — 2026-07-15T05:36:30

> 自顶向下，树状展开，并行探索，面向高 ROI 收束
> — 2026-07-16T17:20:47

> 6–9 小时有点太久了，为什么现在我随便说一个什么实验都要等 6 到 10 个小时才能
> 看到结果？哪怕只是一个这种诊断验证性的实验
> — 2026-07-21T08:13:18

> 如果 M2 gate FAIL：不跑 Unity。把 FAIL 当作机制结论
> — 2026-07-04T05:50:05

> 必须先看 S 地图（即训练地图）的表现 … 然后才谈得上进一步去测试和分析泛化地图
> — 2026-07-28T18:11:29

**confirmation** — this profile is currently thin; most of these are new to it

> stop-gradient control 应使用相同 forward；相同初始化；相同训练预算；相同
> optimizer；只改变梯度路径。否则不能把差异归因于 surrogate gradient
> — 2026-07-14T03:22:04

> 只画两条重合线不足以证明误差很小。至少增加一种：residual inset；RMSE；
> maximum absolute error；exact spike fraction
> — 2026-07-13T13:29:49

> 在没有这组实验前，不要把因果关系写得过满 — use "consistent with", not
> "caused entirely by"
> — 2026-07-13T18:59:08

> 必须在 Methods 中把 criterion 写清楚，不能只凭观察曲线说"快速适应"
> — 2026-07-14T03:22:04

> 不要给 surrogate condition 单独调更长训练或更优学习率，而对 baseline 使用默认
> 参数
> — 2026-07-13T19:01:09

> 视频 episode IDs 必须预先固定，baseline 与 repaired 完全配对，不能根据结果挑
> 最好看的案例
> — 2026-07-12T17:46:44

> 必须有 zero-context / shuffled-context 控制。如果 shuffled 崩，说明
> motion-context 的语义确实重要，不只是额外噪声或正则化
> — 2026-07-03T18:04:03

> 不能在实验完成前把占位符写成已证实结论
> — 2026-07-13T18:57:34

**day-interactive**

> 请先基于 handoff 和代码，用你自己的话系统复述 … 然后进入讨论，一次只问我一个
> 最关键的问题。只有等我们把设计细节讨论清楚，并且我明确说"可以开始写计划"后，
> 你才可以写计划；计划审完且我再次明确允许后，才能改代码或运行实验
> — 2026-07-12T15:39:16

> 然后给新的 debug view 启动指令，我需要人工去复现确认。我复现确认后，再继续
> 其他的
> — 2026-07-23T11:29:42

> 可视化是重要工具，你作为一个语言模型你的图像抽象理解能力还有提升空间所以这里
> 离不开可视化和人类的直觉参与
> — 2026-07-21T04:51:39

> 刚才这张图是示意数据画的，你能改用真实数据画一版我看看是否实现的一致么
> — 2026-07-22T16:04:38

**maieutic**

> 现在关键是怎么做才能保证得到的实验信息是能直接回答我们假设 … 如果我们直接
> 上来就做一个未经过详细考虑的动作，最后出来会存在太多竞争解释
> — 2026-07-22T07:44:29

### D. Two apparent contradictions that are actually phase evidence

Worth keeping because they are the strongest empirical support the framework
has: the same person demanding opposite things, in different phases.

**Seeds**

> 不要只挑最好的一次训练曲线。至少报告：seed 数量；median；interquartile range
> 或 95% bootstrap interval；每个 seed 的最终值
> — 2026-07-13, writing a paper

> 我其实不太在乎跨 seed，我认为这个对于研究阶段影响一点也不大，反而应该一直
> 固定 … 这也不是严谨
> — 2026-07-29, iterating a prototype

**Approval gates**

> 只有等我们把设计细节讨论清楚，并且我明确说"可以开始写计划"后，你才可以写计划
> — 2026-07-12, designing a fix, interactively

> 天啊，都说不让你停下来了，你没听懂么？！！
> — 2026-07-21, overnight unattended execution

**Tests**

> Follow strict TDD: write the specified failing test, run it and confirm the
> expected failure, then implement … tests 必须真实 docker run 已构建镜像，不能
> 只做静态字符串断言
> — 2026-07-11, building tooling with a known spec

> 没有积极主结果前，不做多 seed、全套 ablation、完整 cache 等待或发表级流程
> — 2026-07-29, an unproven idea

Not a contradiction. Rigor is proportional to what you have, and to what kind of
thing you are building. The framework's job is to name which one you are in.

### E. Meta — the question this whole file exists to answer

> 你只把我们的教训写成了一个笔记 markdown 有用么？你怎么保证以后都会读？
> — 2026-07-23T11:34:47

> 怎么把我给你的原则文档写进你每次干活必看的文件里？
> — 2026-07-29T11:34:54

Asked twice, a week apart. A skill loads when it triggers; a note loads never.
Whatever is genuinely load-bearing has to reach the file the harness reads first,
or it is decoration.

### F. Project-specific — deliberately not promoted

Recorded so the decision is visible, not so the rules travel.

- the definition of leakage as "no mirror augmentation of the direction being
  generalised to" — specific to one zero-shot claim
- "不跑 legacy，用本仓库已迁移的版本" — specific to one repository's migration
- CPU-only training being unacceptable — specific to one box's hardware
- gridness as diagnostic-not-selector — specific to one metric
- the two-paper claim boundary — specific to one publication plan
