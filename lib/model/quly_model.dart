// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.products,
    });

    Products? products;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        products: Products.fromJson(json["products"]),
    );

    Map<String, dynamic> toJson() => {
        "products": products!.toJson(),
    };
}

class Products {
    Products({
        this.edges,
    });

    List<Edge>? edges;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges!.map((x) => x.toJson())),
    };
}

class Edge {
    Edge({
        this.node,
    });

    Node? node;

    factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: Node.fromJson(json["node"]),
    );

    Map<String, dynamic> toJson() => {
        "node": node!.toJson(),
    };
}

class Node {
    Node({
        this.id,
        this.name,
        this.description,
        this.thumbnail,
    });

    String? id;
    String? name;
    String? description;
    Thumbnail? thumbnail;

    factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "thumbnail": thumbnail!.toJson(),
    };
}

class Thumbnail {
    Thumbnail({
        this.url,
    });

    String? url;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
