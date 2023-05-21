/******************************************
  Private Google APIs DNS Zone & records.
 *****************************************/

variable "dns" {}
variable "zone_type" {}
variable "host_project_id" {}
variable "network_url" {}


resource "google_dns_managed_zone" "googleapis" {
  project      = var.host_project_id
  name       = "${var.dns}googleapis"
  dns_name   = "googleapis.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "googleapis_a" {
  project      = var.host_project_id
  name         = "private.${google_dns_managed_zone.googleapis.dns_name}"
  managed_zone = google_dns_managed_zone.googleapis.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_managed_zone.googleapis]
}

resource "google_dns_record_set" "googleapis_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.googleapis.dns_name}"
  managed_zone = google_dns_managed_zone.googleapis.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["private.googleapis.com."]

  depends_on = [google_dns_record_set.googleapis_a]
}


resource "google_dns_record_set" "gcr_a" {
  project      = var.host_project_id
  name         = google_dns_managed_zone.gcr.dns_name
  managed_zone = google_dns_managed_zone.gcr.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}

resource "google_dns_record_set" "gcr_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.gcr.dns_name}"
  managed_zone = google_dns_managed_zone.gcr.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["gcr.io."]
}

resource "google_dns_managed_zone" "gcr" {
  project      = var.host_project_id
  name       = "${var.dns}gcr"
  dns_name   = "gcr.io."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}


resource "google_dns_record_set" "appspot_a" {
  project      = var.host_project_id
  name         = google_dns_managed_zone.appspot.dns_name
  managed_zone = google_dns_managed_zone.appspot.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}

resource "google_dns_record_set" "appspot_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.appspot.dns_name}"
  managed_zone = google_dns_managed_zone.appspot.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["appspot.com."]
}

resource "google_dns_managed_zone" "appspot" {
  project      = var.host_project_id
  name       = "${var.dns}appspot"
  dns_name   = "appspot.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}


resource "google_dns_managed_zone" "appengine" {
  project      = var.host_project_id
  name       = "${var.dns}appengine"
  dns_name   = "appengine.google.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "appengine_a" {
  project      = var.host_project_id
  name         = google_dns_managed_zone.appengine.dns_name
  managed_zone = google_dns_managed_zone.appengine.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_managed_zone.appengine]
}


resource "google_dns_managed_zone" "packages" {
  project      = var.host_project_id
  name       = "${var.dns}packages"
  dns_name   = "packages.cloud.google.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "packages-a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.packages.dns_name}"
  managed_zone = google_dns_managed_zone.packages.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_managed_zone.packages]
}


resource "google_dns_managed_zone" "pkg-dev" {
  project      = var.host_project_id
  name       = "${var.dns}pkg-dev"
  dns_name   = "pkg.dev."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "pkg-dev_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.pkg-dev.dns_name}"
  managed_zone = google_dns_managed_zone.pkg-dev.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["pkg.dev."]

  depends_on = [google_dns_managed_zone.pkg-dev]
}

resource "google_dns_record_set" "pkg-dev_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.pkg-dev.dns_name}"
  managed_zone = google_dns_managed_zone.pkg-dev.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_record_set.pkg-dev_cname]
}


resource "google_dns_managed_zone" "composer" {
  project      = var.host_project_id
  name       = "${var.dns}composer"
  dns_name   = "composer.cloud.google.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "composer_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.composer.dns_name}"
  managed_zone = google_dns_managed_zone.composer.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["composer.cloud.google.com."]
}


resource "google_dns_record_set" "composer_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.composer.dns_name}"
  managed_zone = google_dns_managed_zone.composer.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}

resource "google_dns_managed_zone" "source-developers" {
  project      = var.host_project_id
  name       = "${var.dns}source-developers"
  dns_name   = "source.developers.google.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "source-developers_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.source-developers.dns_name}"
  managed_zone = google_dns_managed_zone.source-developers.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_managed_zone.source-developers]
}

resource "google_dns_managed_zone" "notebook_googleusercontent" {
  project      = var.host_project_id
  name       = "${var.dns}notebook-googleusercontent"
  #dns_name   = "googleusercontent.cloud.google.com."
  dns_name   = "notebooks.googleusercontent.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "notebook_googleusercontent_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.notebook_googleusercontent.dns_name}"
  managed_zone = google_dns_managed_zone.notebook_googleusercontent.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["notebooks.googleusercontent.com."]
}


resource "google_dns_record_set" "notebook_googleusercontent_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.notebook_googleusercontent.dns_name}"
  managed_zone = google_dns_managed_zone.notebook_googleusercontent.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}


resource "google_dns_managed_zone" "notebookscloud" {
  project      = var.host_project_id
  name       = "${var.dns}notebooks-cloud"
  dns_name   = "notebooks.cloud.google.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "notebookscloud_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.notebookscloud.dns_name}"
  managed_zone = google_dns_managed_zone.notebookscloud.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["notebooks.cloud.google.com."]
}


resource "google_dns_record_set" "notebookscloud_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.notebookscloud.dns_name}"
  managed_zone = google_dns_managed_zone.notebookscloud.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}


resource "google_dns_managed_zone" "cloudfunctions" {
  project      = var.host_project_id
  name       = "${var.dns}cloudfunctions"
  dns_name   = "cloudfunctions.net."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "cloudfunctions_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.cloudfunctions.dns_name}"
  managed_zone = google_dns_managed_zone.cloudfunctions.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["cloudfunctions.net."]
}

resource "google_dns_record_set" "cloudfunctions_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.cloudfunctions.dns_name}"
  managed_zone = google_dns_managed_zone.cloudfunctions.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}


resource "google_dns_managed_zone" "cloudproxy" {
  project      = var.host_project_id
  name       = "${var.dns}cloudproxy"
  dns_name   = "cloudproxy.app."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "cloudproxy_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.cloudproxy.dns_name}"
  managed_zone = google_dns_managed_zone.cloudproxy.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["cloudproxy.app."]
}

resource "google_dns_record_set" "cloudproxy_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.cloudproxy.dns_name}"
  managed_zone = google_dns_managed_zone.cloudproxy.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}


resource "google_dns_managed_zone" "datafusion_google" {
  project      = var.host_project_id
  name       = "${var.dns}datafusion-google"
  dns_name   = "datafusion.cloud.google.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "datafusion_google_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.datafusion_google.dns_name}"
  managed_zone = google_dns_managed_zone.datafusion_google.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_managed_zone.datafusion_google]
}


resource "google_dns_managed_zone" "datafusion_user" {
  project      = var.host_project_id
  name       = "${var.dns}datafusion-user"
  dns_name   = "datafusion.googleusercontent.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "datafusion_user_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.datafusion_user.dns_name}"
  managed_zone = google_dns_managed_zone.datafusion_user.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_managed_zone.datafusion_user]
}


resource "google_dns_managed_zone" "google" {
  project      = var.host_project_id
  name       = "${var.dns}google"
  dns_name   = "google.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "google_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.google.dns_name}"
  managed_zone = google_dns_managed_zone.google.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["google.com."]
}

resource "google_dns_record_set" "google_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.google.dns_name}"
  managed_zone = google_dns_managed_zone.google.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}


resource "google_dns_managed_zone" "googleadapis" {
  project      = var.host_project_id
  name       = "${var.dns}googleadapis"
  dns_name   = "googleadapis.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "googleadapis_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.googleadapis.dns_name}"
  managed_zone = google_dns_managed_zone.googleadapis.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["googleadapis.com."]
}

resource "google_dns_record_set" "googleadapis_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.googleadapis.dns_name}"
  managed_zone = google_dns_managed_zone.googleadapis.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}


resource "google_dns_managed_zone" "gstatic" {
  project      = var.host_project_id
  name       = "${var.dns}gstatic"
  dns_name   = "gstatic.com."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "gstatic_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.gstatic.dns_name}"
  managed_zone = google_dns_managed_zone.gstatic.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["gstatic.com."]
}

resource "google_dns_record_set" "gstatic_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.gstatic.dns_name}"
  managed_zone = google_dns_managed_zone.gstatic.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}


resource "google_dns_managed_zone" "ltsapis_goog" {
  project      = var.host_project_id
  name       = "${var.dns}ltsapis-goog"
  dns_name   = "ltsapis.goog."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "ltsapis_goog_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.ltsapis_goog.dns_name}"
  managed_zone = google_dns_managed_zone.ltsapis_goog.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["ltsapis.goog."]
}

resource "google_dns_record_set" "ltsapis_goog_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.ltsapis_goog.dns_name}"
  managed_zone = google_dns_managed_zone.ltsapis_goog.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}
##########################################################################################
resource "google_dns_managed_zone" "pki_goog" {
  project      = var.host_project_id
  name       = "${var.dns}pki-goog"
  dns_name   = "pki.goog."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "pki_goog_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.pki_goog.dns_name}"
  managed_zone = google_dns_managed_zone.pki_goog.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]

  depends_on = [google_dns_managed_zone.pki_goog]
}



resource "google_dns_managed_zone" "run_app" {
  project      = var.host_project_id
  name       = "${var.dns}run-app"
  dns_name   = "run.app."
  visibility = var.zone_type
  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "run_app_cname" {
  project      = var.host_project_id
  name         = "*.${google_dns_managed_zone.run_app.dns_name}"
  managed_zone = google_dns_managed_zone.run_app.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["run.app."]
}

resource "google_dns_record_set" "run_app_cname_a" {
  project      = var.host_project_id
  name         = "${google_dns_managed_zone.run_app.dns_name}"
  managed_zone = google_dns_managed_zone.run_app.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}