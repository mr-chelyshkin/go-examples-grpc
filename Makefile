cert:
	cd cert; ./gen.sh; cd ..

gen:
	protoc -I proto --go_out=plugins=grpc:. proto/memory_message.proto
	protoc -I proto --go_out=plugins=grpc:. proto/storage_message.proto
	protoc -I proto --go_out=plugins=grpc:. proto/screen_message.proto
	protoc -I proto --go_out=plugins=grpc:. proto/processor_message.proto
	protoc -I proto --go_out=plugins=grpc:. proto/keyboard_message.proto
	protoc -I proto --go_out=plugins=grpc:. proto/laptop_message.proto
	protoc -I proto --go_out=plugins=grpc:. proto/filter_message.proto
	protoc -I proto --go_out=plugins=grpc:. proto/laptop_service.proto
	protoc -I proto --go_out=plugins=grpc:. proto/auth_service.proto

test:
	go test -cover -race ./...

client:
	go run cmd/client/main.go -address 0.0.0.0:8080

client-tls:
	go run cmd/client/main.go -address 0.0.0.0:8080 -tls

server:
	go run cmd/server/main.go -port 8080

server1:
	go run cmd/server/main.go -port 50051

server2:
	go run cmd/server/main.go -port 50052

server-tls:
	go run cmd/server/main.go -port 8080 -tls

server1-tls:
	go run cmd/server/main.go -port 50051 -tls

server2-tls:
	go run cmd/server/main.go -port 50052 -tls

rest:
	go run cmd/server/main.go -port 8081 -type rest -endpoint 0.0.0.0:8080

.PHONY: cert gen test client client-tls server server1 server2 server-tls server1-tls server2-tls rest
