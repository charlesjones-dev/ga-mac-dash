# Contributions Closed — GA Mac Dashboard

**Retired September 2026.** This project is unmaintained and will receive no further maintenance, features, bug fixes, or security updates. Issues, pull requests, feature proposals, and other contributions are no longer accepted or reviewed. There is no ongoing maintainer review or merge process.

Independent forks are welcome under the existing [MIT License](LICENSE). Preserve its copyright and permission notices as required by the license. Fork maintainers set their own contribution and support policies; this project does not provide support for forks.

See [SUPPORT.md](SUPPORT.md) for the retirement and support policy.

## Historical Development Guidance

The following technical guidance records the former development practices for reference and independent forks. It is no longer maintained or verified against current tools and services. The former upstream contribution workflow has ended.

See the [historical setup instructions](README.md#historical-setup-instructions) and [historical build reference](README.md#historical-build-reference).

### Development Requirements

- macOS 14.0 or later
- Xcode 15.0 or later
- Swift 6.0

### Code Style

- Follow Swift API Design Guidelines
- Use SwiftUI best practices
- Keep code clean and well-commented
- Write meaningful commit messages

### Testing

The former manual testing checklist was:

- Build and run the app in both Debug and Release configurations
- Test on different macOS versions if possible
- Verify the app works with multiple Google Analytics dashboards
- Check that keyboard shortcuts work correctly
- Test grid resizing functionality
