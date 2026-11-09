fn main() {
    // Android 15+ devices can use 16 KB memory pages; a library with 4 KB
    // aligned LOAD segments does not load there, and Google Play requires 16
    // KB alignment. arm64 and x86_64 only (the 64-bit ABIs).
    // See https://developer.android.com/guide/practices/page-sizes#other-build-systems
    let os = std::env::var("CARGO_CFG_TARGET_OS").unwrap();
    let arch = std::env::var("CARGO_CFG_TARGET_ARCH").unwrap();
    if os == "android" && (arch == "aarch64" || arch == "x86_64") {
        println!("cargo:rustc-link-arg=-Wl,-z,max-page-size=16384");
    }
}
