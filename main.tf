terraform {
  required_providers {
    nsxt = {
      source  = "vmware/nsxt"
      version = "3.3.0"
    }
  }
}

data "nsxt_policy_tier0_gateway" "T0" {
  display_name = "T0-GW"
}

data "nsxt_policy_transport_zone" "tz_overlay" {
  display_name = "TZ-OVERLAY"
}

data "nsxt_policy_transport_zone" "tz_vlan" {
  display_name = "TZ-VLAN"
}

data "nsxt_policy_tier1_gateway" "T1_GW" {
  display_name = format("T1-%s", var.location)
}

resource "nsxt_policy_segment" "segment_nsx" {
  display_name        = format("LS-%s-%s", var.location, var.number)
  connectivity_path   = data.nsxt_policy_tier1_gateway.T1_GW.path
  transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path
  subnet {
    cidr = var.segment_cidr
  }
}