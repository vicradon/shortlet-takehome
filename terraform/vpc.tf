resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_compute_router" "router" {
  name    = "${var.project_id}-router"
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.project_id}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "deny-all" {
  name     = "${var.project_id}-deny-all"
  network  = google_compute_network.vpc.name
  priority = 1000

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-http" {
  name     = "${var.project_id}-allow-http"
  network  = google_compute_network.vpc.name
  priority = 900

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-https" {
  name     = "${var.project_id}-allow-https"
  network  = google_compute_network.vpc.name
  priority = 900

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}