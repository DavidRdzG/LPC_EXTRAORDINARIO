import nmap
import sys

if __name__ == '__main__':
    host = sys.argv[1]
    portstrs = sys.argv[2].split('-')


begin = int(portstrs[0])
end = int(portstrs[1])

scanner = nmap.PortScanner()

target = host[0]

for i in range(begin, end):
    res = scanner.scan(target, str(i))
    try:
        state = res['scan'][target]['tcp'][i]['state']
    except KeyError as e:
        print(f"Port: {i} is closed")
    else:
        print(f'Port {i} is {res}')
