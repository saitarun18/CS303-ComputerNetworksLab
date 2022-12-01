import socket as soc

def func():
    host = soc.gethostname ( )
    port = 6969

    server_socket = soc.socket()
    server_socket.bind((host, port))

    server_socket.listen (2)
    conn, address = server_socket.accept()

    print("Connection from: " + str(address))
    while True:
        data = conn.recv(1024).decode()
        if not data:
          break
        print("from connected user: " + str(data))
        data = input(" -> ")
        conn.send(data.encode())
    conn.close()
if __name__ == '__main__':
    func()
