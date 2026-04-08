# Tuhu UAV PX4

基于 PX4 `v1.15.4` 的定制飞控仓库。

这个仓库的目标是保证从 GitHub 重新克隆后，只要把子模块和 Ubuntu 依赖初始化好，就可以直接开始编译。

## 克隆仓库

推荐直接递归克隆：

```bash
git clone --recursive https://github.com/loadinginginging/tuhu_uav_px4.git
cd tuhu_uav_px4
```

如果已经 clone 过但没有带子模块，执行：

```bash
git submodule sync --recursive
git submodule update --init --recursive
```

## Ubuntu 环境初始化

仓库内提供了一层启动脚本，会先同步并更新子模块，再调用 PX4 官方 Ubuntu 依赖安装脚本：

```bash
./scripts/bootstrap_ubuntu.sh
```

说明：

- 默认使用仓库内的 `Tools/setup/ubuntu.sh` 安装依赖。
- 脚本会安装 PX4 NuttX 工具链、Python 依赖、`optional-requirements.txt` 里的额外构建依赖和常用编译工具。
- 脚本结束后，首次使用建议重新打开终端，或执行 `source ~/.profile`，让 `arm-none-eabi-gcc` 的 PATH 生效。

如果你只想装固件编译环境、不装仿真依赖，可以这样执行：

```bash
./scripts/bootstrap_ubuntu.sh --no-sim-tools
```

## 直接编译

当前仓库默认示例编译目标：

```bash
make px4_fmu-v6c_default
```

如果你的硬件目标不是 `px4_fmu-v6c_default`，把上面的 target 替换成实际板卡对应的 PX4 target 即可，例如 `px4_fmu-v6x_default`。

编译产物通常位于：

```text
build/px4_fmu-v6c_default/
```

## 推荐的完整流程

```bash
git clone --recursive https://github.com/loadinginginging/tuhu_uav_px4.git
cd tuhu_uav_px4
./scripts/bootstrap_ubuntu.sh --no-sim-tools
source ~/.profile
make px4_fmu-v6c_default
```

## 仓库说明

- 代码基础版本：PX4 `v1.15.4`
- 子模块通过 `.gitmodules` 管理，重新克隆后必须执行递归初始化
- GitHub Actions 已配置为递归 checkout 子模块，保证 CI 与本地 fresh clone 行为一致

## 上游参考

- PX4 官方仓库：https://github.com/PX4/PX4-Autopilot
- PX4 开发环境说明：https://docs.px4.io/main/en/dev_setup/dev_env.html
